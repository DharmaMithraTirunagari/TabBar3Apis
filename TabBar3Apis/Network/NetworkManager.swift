//
//  NetworkManager.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchData<T: Decodable>(from urlString: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
