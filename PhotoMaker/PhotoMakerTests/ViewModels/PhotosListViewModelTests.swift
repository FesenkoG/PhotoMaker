//
//  PhotosListViewModelTests.swift
//  PhotoMakerTests
//
//  Created by Georgy Fesenko on 4/11/21.
//

import XCTest
@testable import PhotoMaker

class PhotosListViewModelTests: XCTestCase {
    var flow: HomeFlowProtocolMock!
    var repository: PhotosRepositoryProtocolMock!
    var viewModel: PhotosListViewModel!

    override func setUp() {
        super.setUp()
        flow = .init()
        repository = .init()

        repository.getImagesReturnValue = [
            .init(
                image: UIImage(),
                name: "Image0",
                creationDate: .init(timeIntervalSince1970: 42)
            ),
            .init(
                image: UIImage(),
                name: "Image1",
                creationDate: .init(timeIntervalSince1970: 24)
            )
        ]

        viewModel = .init(homeFlow: flow, photosRepository: repository)
    }

    func test_number_of_rows() throws {
        let result = viewModel.numberOfRows()

        XCTAssertEqual(result, 2)
    }

    func test_get_images_number_of_calls() throws {
        _ = viewModel.numberOfRows()
        _ = viewModel.modelFor(indexPath: .init(row: 0, section: 0))
        _ = viewModel.modelFor(indexPath: .init(row: 0, section: 1))

        XCTAssertEqual(repository.getImagesCallsCount, 1)
    }

    func test_model_for_index_path() throws {
        let model = viewModel.modelFor(indexPath: .init(row: 1, section: 0))

        XCTAssertEqual(model, repository.getImagesReturnValue[1])
    }

    func test_did_select() throws {
        viewModel.didSelect(indexPath: .init(row: 0, section: 0))

        XCTAssertEqual(flow.presentPhotoViewImageCalled, true)
    }
}
