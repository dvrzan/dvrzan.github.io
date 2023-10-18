//
//  PortfolioDataStore.swift
//  
//
//  Created by Danijela Vrzan on 2022-03-11.
//

import Foundation

//MARK: - Conferences & Meetups
struct Conference {
  let past: Bool
  let name: String
  let dateAndCity: String
  let talkTitle: String
  let talkURL: String

  static let conferences = [
    Conference(
        past: true,
        name: "🎦 SwiftConnection",
        dateAndCity: "September 2023 - Paris, France",
        talkTitle: "String Catalog: Better Way to Localize Your Apps",
        talkURL: "https://www.youtube.com/watch?v=7XVhDu74v0c"
    ),
    Conference(
        past: true,
        name: "🎦 SwiftTO",
        dateAndCity: "August 2023 - Toronto, Canada",
        talkTitle: "Improve your code with the Swift Algorithms package",
        talkURL: "https://www.youtube.com/watch?v=IXlA7FQo-DQ"
    ),
    Conference(
        past: true,
        name: "DeepDishSwift",
        dateAndCity: "May 2023 - Chicago, US",
        talkTitle: "Algorithms - where no developer wants to go",
        talkURL: ""
    ),
    Conference(
      past: true,
      name: "iOSConfSG",
      dateAndCity: "January 2023 - Singapore, SG",
      talkTitle: "🎦 Improve User Experience with Firebase Dynamic Links",
      talkURL: "https://www.youtube.com/watch?v=fGrjUeJq0xs"
    ),
    Conference(
      past: true,
      name: "Do iOS",
      dateAndCity: "November 2022 - Amsterdam, NL",
      talkTitle: "🎦 Swift your personal website using Publish",
      talkURL: "https://www.youtube.com/watch?v=0gPyM-xKRvM"
    ),
    Conference(
      past: true,
      name: "iOSDevUK",
      dateAndCity: "September 2022 - Aberystwyth, UK",
      talkTitle: "Swift your personal website using Publish",
      talkURL: ""
    ),
    Conference(
      past: true,
      name: "CocoaHeads Hamburg",
      dateAndCity: "June 2022 - Online",
      talkTitle: "Server driven UI with JudoSDK",
      talkURL: ""
    ),
    Conference(
      past: true,
      name: "iOSConfSG",
      dateAndCity: "January 2022 - Online",
      talkTitle: "🎦 VIP, not a VIPER, Clean Swift Architecture",
      talkURL: "https://www.youtube.com/watch?v=Szlgqnk6gHg"
    ),
    Conference(
      past: true,
      name: "NSSpain",
      dateAndCity: "November 2021 - Online",
      talkTitle: "🎦 There's no IF or ELSE. It's all about YOU.",
      talkURL: "https://vimeo.com/646517989"
    ),
    Conference(
      past: true,
      name: "SwiftLeeds",
      dateAndCity: "October 2021 - Leeds, UK",
      talkTitle: "There's no IF or ELSE. It's all about YOU.",
      talkURL: ""
    )
  ]
}


//MARK: - Podcasts and Interviews
struct Podcast {
  let headline: String
  let description: String
  let url: String

  static let podcasts = [
    Podcast(
        headline: "🎙️ MTCJ: SwiftTO 2023 Speaker Series",
        description: "This week Tim sits down with Danijela Vrzan, iOS developer, bootcamp mentor and conference speaker. They discuss her career pivot to becoming an iOS engineer, her life in Croatia and migration with her husband to Canada. They discuss the Kodeco bootcamps and how Danijela became a mentor. They also dig into building website in Swift.",
        url: "https://www.youtube.com/watch?v=kWoArujt2bQ"
    ),
    Podcast(
        headline: "🎙️ The Swift Ascent Podcast",
        description: "In this episode, Ann and Craig talk with Danijela about how she got started in iOS development. What made her get into iOS and her journey along the way? We also go to hear her advice on how she would get started now and things she would change when she was learning.",
        url: "https://podcasts.apple.com/ca/podcast/danijela-vrzan/id1678225194?i=1000605101491"
    ),
    Podcast(
      headline: "🎙️ Slices: The Deep Dish Swift Podcast",
      description: "Chat with Malin and Kai about my talk at Deep Dish Swift conference, windows phones, and Croatian food.",
      url: "https://podcasts.apple.com/ca/podcast/slices-the-deep-dish-swift-podcast/id1670026071?i=1000601927719"
    ),
    Podcast(
      headline: "🎦 Do iOS Panel hosted by Antoine van der Lee",
      description: "In this panel, Tim, Jeremy and I are interviewed by Antoine and answer the questions: What can we expect of future Swift versions? Should you still learn UIKit as a new engineer?",
      url: "https://www.youtube.com/watch?v=JBGf0Pegs5E"
    ),
    Podcast(
      headline: "🎙️ The Mayank Show - This is how you can become an iOS Developer",
      description: "Mayank and I talk about attending WWDC 2022 without a ticket and how someone can become an iOS Developer.",
      url: "https://www.youtube.com/watch?v=gZvGtbaDJp8"
    ),
    Podcast(
      headline: "🎙️ Empower Apps - Coffee Chats",
      description: "Leo and I talk about the importance of meeting with people 1-on-1 and my experience of meeting folks at WWDC 2022.",
      url: "https://www.youtube.com/watch?v=AbK1n_WHsZM"
    ),
    Podcast(
      headline: "🎙️ AppForce1 - WWDC expectations and predictions Twitter Space",
      description: "Jeroen and Stefan have hosted Mikaela, Malin, Josh, Jordi, Rudrank and me to talk about our expectations and predictions for WWDC 2022.",
      url: "https://appforce1.net/podcast/shownotes/?episode=WWDC+expectations+and+predictions+Twitter+Space"
    ),
    Podcast(
      headline: "🎙️ AppForce1 - 1st a civil engineer then a software engineer",
      description: "Jeroen and I talk about my career as a software developer and why I decided to move away from Civil Engineering.",
      url: "https://appforce1.net/podcast/shownotes/?episode=Danijela+Vrzan%2C+1st+a+civil+engineer+then+a+software+engineer"
    ),
    Podcast(
      headline: "🎙️ Everyday Robots - A creative mind",
      description: "Chat with Jonathan about getting into iOS Development and learning how to code. We talk about SwiftUI, UIKit, and writing articles for raywenderlich.com.",
      url: "https://everydayrobots.tech/posts/ep78/"
    ),
    Podcast(
      headline: "💬 iOS Chats - iOS Chat with Danijela Vrzan",
      description: "In this iOS Chat, Filip and I talk about my career switch from Civil Engineering to becoming an iOS Developer, about attending first ever raywenderlich.com iOS bootcamp, and more.",
      url: "https://nemecek.be/chats/danijela-vrzan"
    )
  ]
}
