//
//  HomeViewModelTests.swift
//  PhotoMakerTests
//
//  Created by Georgy Fesenko on 4/11/21.
//


import XCTest
@testable import PhotoMaker

class HomeViewModelTests: XCTestCase {
    var flow: HomeFlowProtocolMock!
    var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        flow = .init()

        viewModel = .init(flow: flow)
    }

    func test_on_make_image() throws {
        viewModel.onMakePhoto()

        XCTAssertEqual(flow.presentCameraCalled, true)
    }

    func test_on_view_image() throws {
        viewModel.onViewPhotos()

        XCTAssertEqual(flow.presentPhotoListCalled, true)
    }
}
