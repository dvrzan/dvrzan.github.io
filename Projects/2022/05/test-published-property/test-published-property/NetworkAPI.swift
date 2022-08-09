//
//  NetworkAPI.swift
//  test-published-property
//
//  Created by Danijela Vrzan on 2022-05-09.
//

import Foundation

protocol NetworkAPI {
  func fetchVideos(from url: URL) async throws -> [Video]
}
