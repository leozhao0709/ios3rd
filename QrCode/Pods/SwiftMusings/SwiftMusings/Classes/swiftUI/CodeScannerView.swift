//
// Created by Lei Zhao on 11/1/20.
//

import SwiftUI
import AVFoundation

// This can scan [.qr, .code128, .code39, .code93, .code39Mod43, .ean8, .ean13, .upce, .pdf417, .aztec] code
public struct CodeScannerView: UIViewControllerRepresentable {

    var onGetCodes: ((_ codes: [String]) -> Void)?
    var onError: ((_ error: Error) -> Void)?

    public init(onGetCodes: (([String]) -> ())? = nil, onError: ((Error) -> ())?) {
        self.onGetCodes = onGetCodes
        self.onError = onError
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    public func makeUIViewController(context: Context) -> Coordinator {
        let controller = Coordinator()
        controller.parentController = self
        return controller
    }

    public func updateUIViewController(_ uiViewController: Coordinator, context: Context) {
    }

    public class Coordinator: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
        let session = AVCaptureSession()
        weak var previewLayer: AVCaptureVideoPreviewLayer?
        var parentController: CodeScannerView?

        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            //1. 获取输入设备
            guard let inputDevice = AVCaptureDevice.default(for: .video) else {
                parentController?.onError?(CustomError("Device not support for code scanning"))
                return
            }

            guard let input = try? AVCaptureDeviceInput(device: inputDevice) else {
                parentController?.onError?(CustomError("Device not support for code scanning"))
                return
            }

            //3. 创建输出对象
            let output = AVCaptureMetadataOutput()
            //4. 设置输出对象的delegate
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            //5. 创建session, 注意session是一个持久的过程, 所以必须定义成global variable
            // let session = AVCaptureSession()
            // self.session = session

            //6. 将输入和输出添加到session中, 注意不能重复添加
            if session.canAddInput(input) {
                session.addInput(input)
            }

            if session.canAddOutput(output) {
                session.addOutput(output)
            }

            //7. 设置输出的数据类型
            output.metadataObjectTypes = [.qr, .code128, .code39, .code93, .code39Mod43, .ean8, .ean13, .upce, .pdf417, .aztec]

            //8.创建预览图层
            let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            view.layer.insertSublayer(previewLayer, at: 0)
            self.previewLayer = previewLayer

            //9. 开始采集数据
            session.startRunning()
        }

        public override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            self.previewLayer?.removeFromSuperlayer()
            self.session.stopRunning()
        }

        // delegate
        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // 以震动的形式告知用户扫描成功
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            self.session.stopRunning()
            self.previewLayer?.removeFromSuperlayer()

            var resultArr = [String]()
            for result in metadataObjects {
                //转换成机器可读的编码数据
                if let code = result as? AVMetadataMachineReadableCodeObject {
                    resultArr.append(code.stringValue ?? "")
                } else {
                    resultArr.append(result.type.rawValue)
                }
            }

            self.parentController?.onGetCodes?(resultArr)
        }
    }

}
