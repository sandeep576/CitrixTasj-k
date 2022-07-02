//
//  NetworkManager.swift
//  CitrixTask
//
//  Created by Sai Sandeep on 02/07/22.
//

import Foundation

enum APIError: Error {
    case internalError
    case serverError
    case parseError
}

protocol NetworkManagerAdapter {
    func fetchMostPopularNews(completion: @escaping (Result<MostPopularNews, APIError>) -> Void)
}

class NetworkManager: NetworkManagerAdapter {

    private let baseUrl = "https://api.nytimes.com"

    private enum Endpoint: String {
        case mostPopular = "/svc/mostpopular/v2/viewed/1.json?api-key=06oWBr7AOaD8URDKirgVSwJyVIAAX1k0"
    }

    private enum Method: String {
        case GET
    }

    func fetchMostPopularNews(completion: @escaping (Result<MostPopularNews, APIError>) -> Void) {
        request(endpoint: .mostPopular, method: .GET, completion: completion)
    }

    private func request<T: Codable>(endpoint: Endpoint, method: Method, completion: @escaping (Result<T, APIError>) -> Void) {
        let path = "\(baseUrl)\(endpoint.rawValue)"

        guard let url = URL(string: path) else { return completion(.failure(.internalError))}

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.sync {
                guard error == nil else { completion(.failure(.serverError)); return }
                do {
                    guard let data = data else { completion(.failure(.serverError)); return }
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.parseError))
                }
            }
        }
        dataTask.resume()
    }

    func downloadImage(url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completion(.failure(.serverError))
                return
            }

            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
}
