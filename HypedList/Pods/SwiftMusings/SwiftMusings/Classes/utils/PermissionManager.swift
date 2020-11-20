//
// Created by Lei Zhao on 11/16/20.
//

import AVKit
import Photos

@available(macCatalyst 13.0, *)
public class PermissionManager {

    public static let sharedInstance = PermissionManager()

    private init() {
    }

    public func checkCameraPermission(onGranted: (() -> Void)? = nil, onNotGranted: ((_ status: AVAuthorizationStatus) -> Void)?) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                onGranted?()
            } else {
                let status = AVCaptureDevice.authorizationStatus(for: .video)
                onNotGranted?(status)
            }
        }
    }

    public func checkPhotoPermission(onGranted: (() -> Void)? = nil, onNotGranted: ((_ status: PHAuthorizationStatus) -> Void)?) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                onGranted?()
            } else {
                let status = PHPhotoLibrary.authorizationStatus()
                onNotGranted?(status)
            }
        }
    }

    public func openSettings(options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsAppURL, options: options, completionHandler: completion)
    }
}
