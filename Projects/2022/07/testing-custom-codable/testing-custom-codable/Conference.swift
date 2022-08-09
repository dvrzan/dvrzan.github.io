//
//  User.swift
//  testing-custom-codable
//
//  Created by Danijela Vrzan on 2022-07-24.
//

import Foundation

struct Conference: Codable, Equatable {
  let name: String
  let city: String
  let country: String
  let date: String
  let days: Int
  let isOnline: Bool

  enum CodingKeys: String, CodingKey {
    case name, city, country, date, days, isOnline
  }
}

extension Conference {
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      name = try container.decode(String.self, forKey: .name)
      city = try container.decode(String.self, forKey: .city)
      country = try container.decode(String.self, forKey: .country)
      date = try container.decode(String.self, forKey: .date)
      days = try container.decode(Int.self, forKey: .days)
      isOnline = (try? container.decode(Bool.self, forKey: .isOnline)) ?? false
    }
}
