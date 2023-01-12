//
//  PortfolioDataStore.swift
//  
//
//  Created by Danijela Vrzan on 2022-03-11.
//

import Foundation

//MARK: - Conference
struct Conference {
  let past: Bool
  let name: String
  let website: String
  let dateAndCity: String
  let talkTitle: String
  let talkDescription: String
  let image: String
  let imageAlt: String
  let talkURL: String

  static let conferences = [
    Conference(
        past: false,
        name: "DeepDishSwift",
        website: "https://deepdishswift.com",
        dateAndCity: "May 2023 - Chicago",
        talkTitle: "UPCOMING: TBA",
        talkDescription: "",
        image: "",
        imageAlt: "",
        talkURL: ""
    ),
    Conference(
      past: false,
      name: "iOSConfSG",
      website: "https://iosconf.sg",
      dateAndCity: "January 2023 - Singapore",
      talkTitle: "Improve User Experience with Firebase Dynamic Links",
      talkDescription: "",
      image: "",
      imageAlt: "",
      talkURL: ""
    ),
    Conference(
      past: true,
      name: "Do iOS",
      website: "https://do-ios.com",
      dateAndCity: "November 2022 - Amsterdam, NL",
      talkTitle: "Swift your personal website using Publish",
      talkDescription: "It's become a norm to own a personal website. For showcasing your portfolio to future employers or sharing knowledge writing blogs; there are many options to choose from. Publish is a framework created by John Sundell that allows you to build static websites using Swift. In this talk, you'll learn everything you wanted to know about Publish to get started building your own website. It's so Swift!",
      image: "",
      imageAlt: "",
      talkURL: "https://www.youtube.com/watch?v=0gPyM-xKRvM"
    ),
    Conference(
      past: true,
      name: "iOSDevUK",
      website: "https://www.iosdevuk.com/",
      dateAndCity: "September 2022 - Aberystwyth, United Kingdom",
      talkTitle: "Swift your personal website using Publish",
      talkDescription: "",
      image: "",
      imageAlt: "",
      talkURL: ""
    ),
    Conference(
      past: true,
      name: "iOSConfSG",
      website: "https://2022.iosconf.sg",
      dateAndCity: "January 2022 - Remote Edition",
      talkTitle: "VIP, not a VIPER, Clean Swift Architecture",
      talkDescription: "VIP and VIPER, while having the same basic components, are quite different in their implementation. They both follow Uncle Bob's Clean Architecture principles and often tend to be mixed up due to their name similarities. This talk will introduce you to the VIP architecture and its principles. While specifically made for UIKit apps to fix the MVC problem (Massive View Controllers), we'll take a look at how we could implement it in SwiftUI apps.",
      image: "",
      imageAlt: "",
      talkURL: "https://www.youtube.com/watch?v=Szlgqnk6gHg"
    ),
    Conference(
      past: true,
      name: "NSSpain",
      website: "https://2021.nsspain.com/index.html",
      dateAndCity: "November 2021 - Remote Edition",
      talkTitle: "There's no IF or ELSE. It's all about YOU.",
      talkDescription: "This talk is my personal story of how I decided to switch my career from Civil Engineering to iOS Development; with no previous programming experience. Following a structured timeline, I talk about some personal successes and all the fears and failures I had to overcome. Finally, I share all the lessons I learned along the way and inspire others to take action. Changing your career doesn’t mean you have failed.",
      image: "",
      imageAlt: "",
      talkURL: "https://vimeo.com/646517989"
    ),
    Conference(
      past: true,
      name: "SwiftLeeds",
      website: "https://swiftleeds.co.uk",
      dateAndCity: "October 2021 - Leeds, United Kingdom",
      talkTitle: "There's no IF or ELSE. It's all about YOU.",
      talkDescription: "",
      image: "../../images/portfolio/conferences/2021/swiftleeds-talk.jpeg",
      imageAlt: "Danijela on stage at SwiftLeeds conference giving a talk with a large panel of her slides in the background.",
      talkURL: ""
    )
  ]
}

//MARK: - Meetup
struct Meetup {
  let past: Bool
  let name: String
  let website: String
  let dateAndCity: String
  let talkTitle: String
  let talkDescription: String
  let image: String
  let imageAlt: String
  let talkURL: String

  static let meetups = [
      Meetup(
        past: true,
        name: "CocoaHeads Hamburg",
        website: "https://twitter.com/cocoaheads_hh",
        dateAndCity: "June 2022 - Remote Edition",
        talkTitle: "Server driven UI with JudoSDK",
        talkDescription: "",
        image: "",
        imageAlt: "",
        talkURL: ""
      )
    ]
}

//MARK: - Interview
struct Interview {
  let headline: String
  let name: String
  let website: String
  let host: String
  let description: String
  let url: String

  static let interviews = [
    Interview(
      headline: "Do iOS Panel hosted by Antoine van der Lee",
      name: "Do iOS Panel",
      website: "https://do-ios.com",
      host: "Antoine van der Lee",
      description: "What can we expect of future Swift version? Should I still learn UIKit as a new engineer? Is there still reason to use Combine while we have async/await? Those and other topics will be discussed in the Do iOS panel.",
      url: "https://www.youtube.com/watch?v=JBGf0Pegs5E"
    ),
    Interview(
      headline: "iOS Chat with Danijela Vrzan",
      name: "iOS Chats",
      website: "https://nemecek.be/chats/",
      host: "Filip Němeček",
      description: "In this iOS Chat, Filip and I talk about my career switch from Civil Engineering to becoming an iOS Developer, about attending first ever raywenderlich.com iOS bootcamp, and more!",
      url: "https://nemecek.be/chats/danijela-vrzan"
    )
  ]
}

//MARK: - Podcast
struct Podcast {
  let headline: String
  let name: String
  let website: String
  let host: String
  let description: String
  let url: String

  static let podcasts = [
    Podcast(
      headline: "This is HOW you can become an iOS Developer",
      name: "The Mayank Show",
      website: "https://www.youtube.com/c/mayankIndia",
      host: "Mayank Gupta",
      description: "In this episode, Mayank and I talk about my professional experiences and perspective on iOS industry. We talk about attending WWDC 2022 without a ticket and how someone can become an iOS Developer irrespective of the field they are currently in.",
      url: "https://www.youtube.com/watch?v=gZvGtbaDJp8"
    ),
    Podcast(
      headline: "Coffee Chats",
      name: "Empower Apps",
      website: "https://www.empowerapps.show/",
      host: "Leo Dion",
      description: "In this episode of Empower Apps podcast, Leo and I talk about the importance of meeting with people 1-on-1. We also talk about my experience of meeting with folks at WWDC 2022.",
      url: "https://www.youtube.com/watch?v=AbK1n_WHsZM"
    ),
    Podcast(
      headline: "WWDC expectations and predictions Twitter Space",
      name: "AppForce1",
      website: "https://appforce1.net",
      host: "Jeroen Leenarts",
      description: "In this episode, Jeroen and Stefan have hosted Mikaela, Malin, Josh, Jordi, Rudrank and me to talk about our expectations and predictions for WWDC 2022. This episode was hosted as a Twitter Space and published as a podcast episode.",
      url: "https://appforce1.net/podcast/shownotes/?episode=WWDC+expectations+and+predictions+Twitter+Space"
    ),
    Podcast(
      headline: "1st a civil engineer then a software engineer",
      name: "AppForce1",
      website: "https://appforce1.net",
      host: "Jeroen Leenarts",
      description: "In this episode of AppForce1 podcast, Jeroen and I talk about my career as a software developer and why I decided to move away from Civil Engineering. We talk about writing articles for raywenderlich.com and programming in general.",
      url: "https://appforce1.net/podcast/shownotes/?episode=Danijela+Vrzan%2C+1st+a+civil+engineer+then+a+software+engineer"
    ),
    Podcast(
      headline: "A creative mind",
      name: "Everyday Robots",
      website: "https://everydayrobots.tech/",
      host: "Jonathan Ruiz",
      description: "In this episode, Jonathan and I talk about getting into iOS Development and learning how to code. We talk about SwiftUI, UIKit, and about writing articles for raywenderlich.com.",
      url: "https://everydayrobots.tech/posts/ep78/"
    )
  ]
}
