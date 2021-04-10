//
//  PermissionsManager.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import AVFoundation

final class PermissionsManager {
    func verifyCameraPermissions(onSuccess: @escaping () -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            onSuccess()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                guard $0 else { return }
                DispatchQueue.main.async {
                    onSuccess()
                }
            }
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
    }
}
