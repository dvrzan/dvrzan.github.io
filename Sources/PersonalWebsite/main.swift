import Foundation
import Publish
import Plot
import DarkImagePublishPlugin
import SplashPublishPlugin
import ReadingTimePublishPlugin

// MARK: - Configuration
// This type acts as the configuration for your website.
struct PersonalWebsite: Website {
  enum SectionID: String, WebsiteSectionID {
    // Add the sections that you want your website to contain here:
    case posts
    case portfolio = "speaking"
    case about
  }

  // Add any site-specific metadata that you want to use here.
  struct ItemMetadata: WebsiteItemMetadata {
    var date: Date
    var description: String
    var tags: Tag
  }

  // Update these properties to configure your website:
  var url = URL(string: "https://danijelavrzan.com")!
  var name = "Danijela's blog"
  var description = "All things Swift and more"
  var language: Language { .english }
  var imagePath: Path? { "images/social.png" }
  var twitterCard: TwitterCardType { .summaryLargeImage }
}

extension Theme {
  static var myTheme: Theme {
    Theme(htmlFactory: MyHTMLFactory(),
          resourcePaths: ["Resources/my-theme/styles.css"]
    )
  }
}

// Generate website using my theme:
try PersonalWebsite().publish(using: [
  .installPlugin(.splash(withClassPrefix: "")),
//  .addMarkdownFiles(),
  .copyResources(),
  .installPlugin(.darkImage()),
  .installPlugin(.readingTime()),
  .generateHTML(withTheme: .myTheme),
  .generateRSSFeed(including: [.posts]),
  .generateSiteMap(),
  .deploy(using: .gitHub("dvrzan/dvrzan.github.io", branch: "main", useSSH: false))
])
