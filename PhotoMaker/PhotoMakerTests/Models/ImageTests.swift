//
//  ImageTests.swift
//  PhotoMakerTests
//
//  Created by Georgy Fesenko on 4/11/21.
//

import XCTest
@testable import PhotoMaker

class ImageTests: XCTestCase {
    func test_mapping_to_store() throws {
        let domain = Image(
            image: UIImage(),
            name: "Name",
            creationDate: Date(timeIntervalSince1970: 42)
        )

        let storeDto = ImageStoreDto(from: domain)
        let givenDomain = storeDto.toDomain()

        XCTAssertEqual(givenDomain.creationDate, domain.creationDate)
        XCTAssertEqual(givenDomain.name, domain.name)
    }
}
