//
//  MockNetworkManager.swift
//  CitrixTaskTests
//
//  Created by Sai Sandeep on 02/07/22.
//

import Foundation
@testable import CitrixTask

class MockNetworkManager: NetworkManagerAdapter {
    var fetchMostPopularNewsCb: ((_ completion: @escaping (Result<MostPopularNews, APIError>) -> Void) -> Void)?
}

extension MockNetworkManager {

    func fetchMostPopularNews(completion: @escaping (Result<MostPopularNews, APIError>) -> Void) {
        fetchMostPopularNewsCb?(completion)
    }

}
