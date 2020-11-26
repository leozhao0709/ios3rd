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
      onComplete: ((_ result: [SNClassification]) -> Void)? = nil,
      onError: ((Error) -> Void)?
    ) {
        let observer = AudioClassifierObserver(onComplete: onComplete, onError: onError)

        guard let request = try? SNClassifySoundRequest(mlModel: self.model),
              let analyzer = try? SNAudioFileAnalyzer(url: audioUrl),
              let _ = try? analyzer.add(request, withObserver: observer)
          else {
            onError?(CustomError("Cannot add request to SNAudioFileAnalyzer"))
            return
        }
    }
}

@available(macCatalyst 13.0, *)
class AudioClassifierObserver: NSObject, SNResultsObserving {
    var onComplete: ((_ result: [SNClassification]) -> Void)?
    var onError: ((Error) -> Void)?

    init(onComplete: (([SNClassification]) -> ())?, onError: ((Error) -> ())?) {
        self.onComplete = onComplete
        self.onError = onError
        super.init()
    }

    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let results = result as? SNClassificationResult
          else {
            onError?(CustomError("Cannot get request result"))
            return
        }

        onComplete?(results.classifications)
    }

}
