//
//  MockNetworkManager.swift
//  test-published-propertyTests
//
//  Created by Danijela Vrzan on 2022-05-09.
//

import Foundation
@testable import test_published_property

class MockNetworkManager: NetworkAPI {
  func fetchVideos(from url: URL) async throws -> [Video] {
    return Seeds.videos
  }
}
