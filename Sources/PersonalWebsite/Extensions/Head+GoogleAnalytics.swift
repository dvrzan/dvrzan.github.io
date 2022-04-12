//
//  Head+GoogleAnalytics.swift
//  
//
//  Created by Danijela Vrzan on 2022-04-11.
//

import Plot

public extension Node where Context == HTML.DocumentContext {
  static func googleAnalytics() -> Node {
    .head(
      .script(.src("https://www.googletagmanager.com/gtag/js?id=G-B5B41JSFC7")),
      .script(
        """
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());

          gtag('config', 'G-B5B41JSFC7');
        """
      )
    )
  }
}
