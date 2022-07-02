//
//  MostPopularNewsViewModel.swift
//  CitrixTask
//
//  Created by Sai Sandeep on 02/07/22.
//

import Foundation

class MostPopularNewsViewModel {

    var service: NetworkManagerAdapter!

    init(service: NetworkManagerAdapter) {
        self.service = service
    }

    func getMostPopularNews(completion: @escaping (Result<[Results], APIError>) -> Void) {
        service.fetchMostPopularNews {
            switch $0 {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

