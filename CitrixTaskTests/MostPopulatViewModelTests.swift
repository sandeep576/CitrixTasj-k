//
//  MostPopulatViewModelTests.swift
//  CitrixTaskTests
//
//  Created by Sai Sandeep on 02/07/22.
//

import Foundation
import XCTest
@testable import CitrixTask

class MostPopulatViewModelTests: XCTestCase {

    func test_fetchMostPopularFailure() {
        let mockService = MockNetworkManager()
        let viewModel = MostPopularNewsViewModel(service: mockService)

        let doCallExpectation = XCTestExpectation(description: "Should call fetch most popular api with error")
        mockService.fetchMostPopularNewsCb = { handler in
            handler(Result<MostPopularNews, APIError>.failure(APIError.serverError))
        }

        viewModel.getMostPopularNews { result in
            doCallExpectation.fulfill()
        }
        wait(for: [doCallExpectation], timeout: 1)
    }

    func test_fetchMostPopularSucess() {
        let mockService = MockNetworkManager()
        let viewModel = MostPopularNewsViewModel(service: mockService)

        let doCallExpectation = XCTestExpectation(description: "Should call fetch most popular api with success")
        mockService.fetchMostPopularNewsCb = { handler in
            guard let fakeData = self.loadDataFrom("MostPopularData") else { handler(Result<MostPopularNews, APIError>.failure(APIError.serverError)); return }
            print(fakeData)
            handler(Result<MostPopularNews, APIError>.success(fakeData))
        }

        viewModel.getMostPopularNews { result in
            doCallExpectation.fulfill()
        }
        wait(for: [doCallExpectation], timeout: 1)
    }

    func loadDataFrom(_ fileName: String) -> MostPopularNews? {
        do {
            if let bundlePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(MostPopularNews.self,  from: jsonData)
                return decodedData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
