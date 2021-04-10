//
//  HomeViewModel.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import Foundation

final class HomeViewModel {
    private let flow: HomeFlow

    init(flow: HomeFlow) {
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
