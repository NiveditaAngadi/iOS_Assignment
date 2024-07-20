//
//  WebService.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 18/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

protocol API {
    static var baseUrl: URL { get }
}

public enum Target: RawRepresentable, API {
    public init?(rawValue: String) { nil }
    
    static let baseUrl = URL(string: "https://api.target.com/mobile_case_study_deals/v1")!
    
    case getDeals
    case getDealDetails(id: Int)
    
    public var rawValue: String {
        switch self {
        case .getDeals: return "deals"
        case .getDealDetails(let id): return "deals/\(id)"
      }
    }
}

extension RawRepresentable where RawValue == String, Self: API {
    var url: URL { Self.baseUrl.appendingPathComponent(rawValue) }
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    case connectionError
}

struct Resource<T: Codable> {
    let url: URL
}

final class WebService {
    @available(*, renamed: "load(resource:)")
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func load<T>(resource: Resource<T>) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            load(resource: resource) { result in
                continuation.resume(with: result)
            }
        }
    }
}
