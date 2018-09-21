//
//  APIClient.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation
import Alamofire
import BrightFutures

internal protocol APIClientRoute {
    var url: URL { get }
}

internal enum APIClientError: Error {
    case requestFailed(Error)
    case decodingFailed(Error)
    case emptyData
}

internal enum APIClientHTTPMethod: String {
    // TODO: Add more HTTP Methods once we need them
    case GET
}

internal protocol APIClient {
    func request<T: Decodable>(route: APIClientRoute, method: APIClientHTTPMethod, parameters: [String: Any]) -> Future<T, APIClientError>
}

internal func APIClientDefault() -> APIClient {
    return APIClientImpl()
}

// Wrapper around alamofire

private final class APIClientImpl: APIClient {

    private func alamofireHTTPMethod(from method: APIClientHTTPMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .GET: return Alamofire.HTTPMethod.get
        }
    }
    
    func request<T: Decodable>(route: APIClientRoute, method: APIClientHTTPMethod, parameters: [String: Any]) -> Future<T, APIClientError> {
        return Future { completion in
            
            let afRequest = Alamofire.request(
                route.url,
                method: alamofireHTTPMethod(from: method),
                parameters: parameters,
                encoding: URLEncoding.default
            )
            
            afRequest.responseData { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(APIClientError.requestFailed(error)))
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(APIClientError.decodingFailed(error)))
                    }
                }
            }
        }
    }
}
