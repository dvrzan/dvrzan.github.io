//
//  NetworkManager.swift
//  test-published-property
//
//  Created by Danijela Vrzan on 2022-05-09.
//

import Foundation

class NetworkManager: NetworkAPI {
  func fetchVideos(from url: URL) async throws -> [Video] {
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Video].self, from: data)
  }
}
