//
//  HTMLFactory.swift
//  
//
//  Created by Danijela Vrzan on 2022-01-28.
//

import Foundation
import Publish
import Plot
import ReadingTimePublishPlugin


// MARK: Header
private struct SiteHeader<Site: Website>: Component {
  var context: PublishingContext<Site>
  var selectedSelectionID: Site.SectionID?

  var body: Component {
    Header {
      Wrapper {
        //Header banner image
        Link(url: Constants.URL.homeURL) {
            Image(Constants.Image.header)
                .accessibilityLabel("Danijela Vrzan text logo header")
            .class("banner-img")
        }

        //Header title
        Paragraph {
          Text(Constants.Header.title)
        }
        .class("banner-title")

        //Header subtitle
        Paragraph {
          Text(Constants.Header.subtitle)
        }
        .class("banner-subtitle")

        //Navigation
        if Site.SectionID.allCases.count > 1 {
          navigation
        }
      }
    }
  }

  // MARK: Navigation
  private var navigation: Component {
    Navigation {
      List(Site.SectionID.allCases) { sectionID in
        let section = context.sections[sectionID]

        return Link(section.title, url: section.path.absoluteString)
          .class(sectionID == selectedSelectionID ? "selected" : "")
      }
    }
  }
}

// MARK: Item List
// List of blog posts
private struct ItemList<Site: Website>: Component {
  var items: [Item<Site>]
  var site: Site

  var body: Component {
    //List of all items (blogs)
    List(items) { item in
      Div {
        //Blog title with link
        H1(Link(item.title, url: item.path.absoluteString))

        //Small divider
        SmallDivider()

        Paragraph {
          //Blog metadata (reading time and date)
          ItemMetadata(item: item, site: site)
          //List of tags for the blog
          ItemTagList(item: item, site: site)
        }

        //Blog short description
        Paragraph(item.description)
          .class("item-description")

        //Read more
          H3(Link(Constants.Components.readMore, url: item.path.absoluteString))
      }
    }
    .class("item-list")
  }
}

// List of recent blog posts - in the past month from today
private struct RecentItemList<Site: Website>: Component {
  var items: [Item<Site>]
  var site: Site

  var body: Component {
    List(items.filter({ post in
      let date = Date()
      let calendar = Calendar.current
      let components = DateComponents(month: -1)
      let oneMonthAgo = calendar.date(byAdding: components, to: date) ?? date
      return post.date > oneMonthAgo && post.date < date
    })) { item in
      Div {
        //Blog title with link
        H1(Link(item.title, url: item.path.absoluteString))

        //Small divider
        SmallDivider()

        Paragraph {
          //Blog metadata (reading time and date)
          ItemMetadata(item: item, site: site)
          //List of tags for the blog
          ItemTagList(item: item, site: site)
        }

        //Blog short decription
        Paragraph(item.description)
          .class("item-description")

        //Read more
          H3(Link(Constants.Components.readMore, url: item.path.absoluteString))
      }
    }
    .class("item-list")
  }
}

//Item Metadata
private struct ItemMetadata<Site: Website>: Component {
  var item: Item<Site>
  var site: Site

  //Format for the date (ex. 24 Jun, 2022)
  var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM, y"
    return formatter.string(from: item.date)
  }

  var body: Component {
    Paragraph {
      //Date the blog was published
      Text(formattedDate)

      //Divider (circle dot)
        Text(Constants.Components.circleDot)

      //Reading time
      Text("\(item.readingTime.minutes) minute read")
    }
    .class("item-metadata")
  }
}

//MARK: Item Tag List
private struct ItemTagList<Site: Website>: Component {
  var item: Item<Site>
  var site: Site

  var body: Component {
    List(item.tags) { tag in
      Link(tag.string, url: site.path(for: tag).absoluteString)
        .class("\(tag.string.replacingOccurrences(of: " ", with: ""))-tag")
    }
    .class("tag-list")
  }
}

// MARK: Section Content
private struct SectionContent<Site: Website>: Component {
  var sectionID: Site.SectionID?
  var context: PublishingContext<Site>
  var items: [Item<Site>]

  var body: Component {
    guard let sectionID = sectionID as? PersonalWebsite.SectionID else {
      return ErrorPage404()
    }

    //Switch between different website sections
    switch sectionID {
    case .about:
      return AboutPage()
    case .portfolio:
      return PortfolioPage()
    case .posts:
      return ItemList(
        items: context.allItems(
          sortedBy: \.date,
          order: .descending
        ),
        site: context.site
      )
    }
  }
}

// MARK: Footer
private struct SiteFooter: Component {
  var body: Component {
    Footer {
      //Copyright
      Paragraph {
        Text(Constants.Footer.copyright)
      }

      //Publish mention
      Paragraph {
        Text(Constants.Footer.generatedUsing)
        Link(Constants.Footer.publish, url: Constants.Footer.publishURL)
          .linkTarget(.blank)
          
        Text(" ")
        Link("RSS.", url: Constants.URL.rss)
          .linkTarget(.blank)
      }
    }
  }
}

// MARK: - Error Page 404
struct ErrorPage404: Component {
  var body: Component {
    Wrapper {
      Image("/images/error/page-not-found.png")
      H1("404 - LOST IN SPACE")
      H3("You have reached the edge of the universe")
      H2(Link("Home", url: Constants.URL.homeURL))
    }
    .class("error-404-page")
  }
}

// MARK: Portfolio Page
private struct PortfolioPage: Component {
  var body: Component {
    Div {
      //Conferences
      H1(Constants.Portfolio.conferenceTitle)
      LargeDivider()
      ConferenceList()

      //Podcasts
      H1(Constants.Portfolio.podcastTitle)
      LargeDivider()
      PodcastList()
    }
    .class("portfolio-page")
  }
}

// MARK: Conferences
private struct ConferenceList: Component {
  var body: Component {
    //List of conferences
    List(Conference.conferences) { conference in
      Div {
        //Conference talk title and URL (if exists)
        H2(
          conference.talkURL == ""
          ? Text(conference.talkTitle)
          : Link(conference.talkTitle, url: conference.talkURL)
            .linkTarget(.blank)
        )

        //Conference information (name, date, place, website)
        Paragraph {
          Link("➔ \(conference.name) - \(conference.dateAndCity)", url: conference.website)
            .linkTarget(.blank)
        }

        //Conference talk description
        Paragraph {
          Text(conference.talkDescription)
        }
        .class("portfolio-description")
      }
    }
    .class("portfolio-section")
  }
}

// MARK: Podcasts
private struct PodcastList: Component {
  var body: Component {
    //List of podcasts
    List(Podcast.podcasts) { podcast in
      Div {
        //Podcast title and URL
        H2(
          Link(podcast.headline, url: podcast.url)
            .linkTarget(.blank)
        )

        //Podcast description
        Paragraph {
          Text(podcast.description)
        }
        .class("portfolio-description")
      }
    }
    .class("portfolio-section")
  }
}

// MARK: - About Section
private struct AboutPage: Component {
  var body: Component {
    Div {
      //Intro title (Hello)
      H1(Constants.About.introTitle)
        .class("home-intro-title")

      LargeDivider()

      Div {
        //Introduction - company I work at, website, and years of experience
        Paragraph {
          Text(Constants.About.introAboutFirst)
          Link(
            Constants.About.introAboutCompanyLink,
            url: Constants.URL.company
          )
          .linkTarget(.blank)
          Text(Constants.About.introAboutExperience)
        }

        //First paragraph - about me (experience)
        Paragraph {
          Text(Constants.About.firstParagraph)
        }

        //Second paragraph - free time
        Paragraph {
          Text(Constants.About.secondParagraph)
        }

        //Image Toronto nature
        Image(
          url: Constants.Image.torontoNature,
          description: "Five photos of Toronto's ravines and natural parks showing rivers, forests, and flowers turned into one image collage."
        )
        .class("about-me-toronto-nature")
        .accessibilityLabel("Five photos of Toronto's ravines and natural parks showing rivers, forests, and flowers turned into one image collage.")
      }
      .class("about-me-text")

      MiddleDivider()

      //Contact title
      Paragraph {
        Text(Constants.About.contactTitle)
        Link(
          Constants.About.contactLink,
          url: Constants.URL.mailTo
        )
        Text(Constants.About.contactTitleEnd)
      }
      .class("about-me-contact-info")

      //Contact me
      Paragraph {
        //Twitter
        Link(url: Constants.URL.twitter) {
          Image(url: Constants.Image.twitter, description: "Twitter logo")
                .accessibilityLabel("Twitter logo")
        }
        .linkTarget(.blank)

        //Linkedin
        Link(url: Constants.URL.linkedin) {
          Image(url: Constants.Image.linkedin, description: "LinkedIn logo")
                .accessibilityLabel("LinkedIn logo")
        }
        .linkTarget(.blank)

        //Github
        Link(url: Constants.URL.github) {
          Image(url: Constants.Image.github, description: "Github logo")
                .accessibilityLabel("Github logo")
        }
        .linkTarget(.blank)

        //Kodeco
        Link(url: Constants.URL.kodeco) {
          Image(url: Constants.Image.kodeco, description: "Kodeco logo")
                .accessibilityLabel("Kodeco logo")
        }
        .linkTarget(.blank)
      }
      .class("about-contact-images")
    }
    .class("portfolio-page")
  }
}



// MARK: - HTML Factory

struct MyHTMLFactory<Site: Website>: HTMLFactory {

  // MARK: Index Page
  func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .head(for: index, on: context.site),
      .googleAnalytics(),
      .body {
        //Header
        SiteHeader(context: context, selectedSelectionID: nil)

        Wrapper {
          H1(Constants.IndexPage.recentPosts)
            .class("home-recent-posts-title")
          Paragraph {
            Text(Constants.IndexPage.intro)
          }

          //Feed.rss subscription
          Paragraph {
            Link(url: Constants.URL.rss) {
                Image(Constants.Image.rss)
                    .accessibilityLabel("")
              Text(Constants.IndexPage.subscribe)
            }
            .linkTarget(.blank)
          }
          .class("rss")

          //List of recent blog posts (last month)
          RecentItemList(
            items: context.allItems(
              sortedBy: \.date,
              order: .descending
            ),
            site: context.site
          )
        }

        //Footer
        SiteFooter()
      }
    )
  }


  // MARK: - Make Section
  // Sections: Pages that can be navigated using navigation
  func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .head(for: section, on: context.site),
      .googleAnalytics(),
      .body {
        //Header
        SiteHeader(context: context, selectedSelectionID: section.id)

        //Section content
        Wrapper {
          SectionContent(sectionID: section.id, context: context, items: section.items)
        }

        //Footer
        SiteFooter()
      }
    )
  }

  // MARK: Make Item
  // Item: One blog post
  func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .head(for: item, on: context.site),
      .googleAnalytics(),
      .body {
        //Header
        SiteHeader(context: context, selectedSelectionID: item.sectionID)
        Wrapper {
          //Blog metadata (tags, date, and reading time)
          Div {
            ItemTagList(item: item, site: context.site)
            ItemMetadata(item: item, site: context.site)
          }
          .class("article-metadata")

          //Blog body
          Article {
            Div(item.body)
              .class("content")
          }
        }
        .class("item-page")

        //Footer
        SiteFooter()
      }
    )
  }

  // MARK: Make Page
  // Pages: Pages that cannot be navigated using navigation
  func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .head(for: page, on: context.site),
      .googleAnalytics(),
      .body {
        SiteHeader(context: context, selectedSelectionID: nil)
        Wrapper(page.body)
        SiteFooter()
      }
    )
  }

  // MARK: Make Tag List
  // Tag List Page: Page that shows a list of all tags
  func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
    HTML(
      .lang(context.site.language),
      .head(for: page, on: context.site),
      .googleAnalytics(),
      .body {
        //Header
        SiteHeader(context: context, selectedSelectionID: nil)

        //List of all tags
        Wrapper {
          H1(Constants.Tags.browseAll)
          List(page.tags.sorted()) { tag in
            ListItem {
              Link(tag.string,
                   url: context.site.path(for: tag).absoluteString
              )
              .class("\(tag.string.replacingOccurrences(of: " ", with: ""))-tag")
            }
            .class("tag")
          }
          .class("all-tags")
        }
        SiteFooter()
      }
    )
  }

  // MARK: Make Tag Details Page
  // Tag Details Page: Page that shows a list of posts with a specified <tag>
  func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
    HTML(
      .lang(context.site.language),
      .head(for: page, on: context.site),
      .googleAnalytics(),
      .body {
        //Header
        SiteHeader(context: context, selectedSelectionID: nil)

        Wrapper {
          //Specified <tag> name
          H1 {
            Text(Constants.Tags.taggedWith)
            Span(page.tag.string)
              .class("tag")
              .class("\(page.tag.string.replacingOccurrences(of: " ", with: ""))-tag")
          }

          //Link to browse all tags
          Link(Constants.Tags.browseAll,
               url: context.site.tagListPath.absoluteString
          )
          .class("browse-all")

          //List of blogs with a specified <tag>
          ItemList(
            items: context.items(
              taggedWith: page.tag,
              sortedBy: \.date,
              order: .descending
            ),
            site: context.site
          )
        }

        //Footer
        SiteFooter()
      }
    )
  }
}
