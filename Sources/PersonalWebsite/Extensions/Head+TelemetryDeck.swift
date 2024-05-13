//
//  Head+TelemetryDeck.swift
//
//
//  Created by Danijela Vrzan on 2022-04-11.
//

import Plot

public extension Node where Context == HTML.DocumentContext {
  static func telemetryDeck() -> Node {
    .head(
        .script(
            .src("https://cdn.telemetrydeck.com/websdk/telemetrydeck.min.js"),
            .data(named: "app-id", value: "47BA20EC-6342-4CAA-88C2-3B4AD29DB8B9")
        )
    )
  }
}
