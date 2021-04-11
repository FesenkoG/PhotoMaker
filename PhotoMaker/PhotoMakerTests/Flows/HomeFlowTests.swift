//
//  HomeFlowTests.swift
//  PhotoMakerTests
//
//  Created by Georgy Fesenko on 4/11/21.
//

import XCTest
@testable import PhotoMaker

class HomeFlowTests: XCTestCase {
    var flow: HomeFlow!
    var navigationController: UINavigationController!
    var screenFactory: ScreenFactoryProtocolMock!
    var photosRepository: PhotosRepositoryProtocolMock!
    var permissionsManager: PermissionsManagerProtocolMock!

    override func setUp() {
        super.setUp()
        navigationController = .init()
        screenFactory = .init()
        photosRepository = .init()
        permissionsManager = .init()

        flow = .init(
            navigationController: navigationController,
            screenFactory: screenFactory,
            photosRepository: photosRepository,
            permissionsManager: permissionsManager
        )
    }

    func test_photo_list_presentation() throws {
        let viewController = UIViewController()
        screenFactory.makePhotosListScreenFlowReturnValue = viewController

        flow.presentPhotoList()

        XCTAssertEqual(screenFactory.makePhotosListScreenFlowCalled, true)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers[0], viewController)
    }

    func test_photo_preview_presentation() throws {
        screenFactory.makeSavePhotoAlertCompletionReturnValue = UIViewController()

        flow.presentPhotoPreview(image: .init(), creationDate: .init())

        XCTAssertEqual(screenFactory.makeSavePhotoAlertCompletionCalled, true)

        XCTAssertEqual(photosRepository.storeImageImageCallsCount, 0)
        screenFactory.makeSavePhotoAlertCompletionReceivedCompletion?("")

        XCTAssertEqual(photosRepository.storeImageImageCallsCount, 1)
    }

    func test_photo_view_presentation() throws {
        let viewController = UIViewController()
        screenFactory.makePhotoFullScreenImageReturnValue = viewController

        flow.presentPhotoList()

        XCTAssertEqual(screenFactory.makePhotoFullScreenImageCalled, true)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers[0], viewController)
    }
}
