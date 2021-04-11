//
//  PermissionsManager.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import AVFoundation

protocol PermissionsManagerProtocol {
    func verifyCameraPermissions(onSuccess: @escaping () -> Void)
}

final class PermissionsManager: PermissionsManagerProtocol {
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
