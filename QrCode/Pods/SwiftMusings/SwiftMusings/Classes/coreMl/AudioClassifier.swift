//
// Created by Lei Zhao on 11/25/20.
//

import Foundation
import SoundAnalysis

@available(macCatalyst 13.0, *)
public class AudioClassifier {

    private let model: MLModel

    public init?(model: MLModel) {
        self.model = model
    }

    public func classify(
      audioUrl: URL,
      onComplete: ((_ result: [SNClassification], _ error: Error?) -> Void)?
    ) {
        let observer = AudioClassifierObserver(onComplete: onComplete)

        guard let request = try? SNClassifySoundRequest(mlModel: self.model),
              let analyzer = try? SNAudioFileAnalyzer(url: audioUrl),
              let _ = try? analyzer.add(request, withObserver: observer)
          else {
            onComplete?([], CustomError("Cannot add request to SNAudioFileAnalyzer"))
            return
        }
    }
}

@available(macCatalyst 13.0, *)
class AudioClassifierObserver: NSObject, SNResultsObserving {
    var onComplete: ((_ result: [SNClassification], _ error: Error?) -> Void)?

    init(onComplete: ((_ result: [SNClassification], _ error: Error?) -> Void)?) {
        self.onComplete = onComplete
        super.init()
    }

    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let results = result as? SNClassificationResult
          else {
            onComplete?([], CustomError("Cannot get request result"))
            return
        }

        onComplete?(results.classifications, nil)
    }

}
