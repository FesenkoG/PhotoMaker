//
//  HomeViewModel.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import Foundation

final class HomeViewModel {
    private let flow: HomeFlowProtocol

    init(flow: HomeFlowProtocol) {
        self.flow = flow
    }
}

extension HomeViewModel {
    func onMakePhoto() {
        flow.presentCamera()
    }

    func onViewPhotos() {
        flow.presentPhotoList()
    }
}
