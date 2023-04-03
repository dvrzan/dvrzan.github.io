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
  let website: String
  let dateAndCity: String
  let talkTitle: String
  let talkDescription: String
  let talkURL: String

  static let conferences = [
    Conference(
        past: false,
        name: "DeepDishSwift",
        website: "https://deepdishswift.com",
        dateAndCity: "May 2023 - Chicago",
        talkTitle: "Algorithms - where no developer wants to go",
        talkDescription: "We need to iterate over a collection of elements, so we write a for loop. It's simple, easy, and it works. And we know the syntax. We don't even think about it. The code flows right through our fingertips. We hold on to familiar. But we're also curious. We learn and investigate every day. Let's satisfy our curiosity and go on an adventure to explore the unfamiliar.",
        talkURL: ""
    ),
    Conference(
      past: true,
      name: "iOSConfSG",
      website: "https://iosconf.sg",
      dateAndCity: "January 2023 - Singapore",
      talkTitle: "Improve User Experience with Firebase Dynamic Links",
      talkDescription: "Learn how Firebase Dynamic Links can help you improve the user experience of your app. Dynamic Links work on top of Universal Links and survive the installation process.",
      talkURL: "https://www.youtube.com/watch?v=fGrjUeJq0xs"
    ),
    Conference(
      past: true,
      name: "Do iOS",
      website: "https://do-ios.com",
      dateAndCity: "November 2022 - Amsterdam, NL",
      talkTitle: "Swift your personal website using Publish",
      talkDescription: "It's become a norm to own a personal website. For showcasing your portfolio to future employers or sharing knowledge writing blogs; there are many options to choose from. Publish is a framework created by John Sundell that allows you to build static websites using Swift. In this talk, you'll learn everything you wanted to know about Publish to get started building your own website. It's so Swift!",
      talkURL: "https://www.youtube.com/watch?v=0gPyM-xKRvM"
    ),
    Conference(
      past: true,
      name: "iOSDevUK",
      website: "https://www.iosdevuk.com/",
      dateAndCity: "September 2022 - Aberystwyth, United Kingdom",
      talkTitle: "Swift your personal website using Publish",
      talkDescription: "",
      talkURL: ""
    ),
    Conference(
      past: true,
      name: "CocoaHeads Hamburg",
      website: "https://twitter.com/cocoaheads_hh",
      dateAndCity: "June 2022 - Remote Edition",
      talkTitle: "Server driven UI with JudoSDK",
      talkDescription: "",
      talkURL: ""
    ),
    Conference(
      past: true,
      name: "iOSConfSG",
      website: "https://2022.iosconf.sg",
      dateAndCity: "January 2022 - Remote Edition",
      talkTitle: "VIP, not a VIPER, Clean Swift Architecture",
      talkDescription: "VIP and VIPER, while having the same basic components, are quite different in their implementation. They both follow Uncle Bob's Clean Architecture principles and often tend to be mixed up due to their name similarities. This talk will introduce you to the VIP architecture and its principles. While specifically made for UIKit apps to fix the MVC problem (Massive View Controllers), we'll take a look at how we could implement it in SwiftUI apps.",
      talkURL: "https://www.youtube.com/watch?v=Szlgqnk6gHg"
    ),
    Conference(
      past: true,
      name: "NSSpain",
      website: "https://2021.nsspain.com/index.html",
      dateAndCity: "November 2021 - Remote Edition",
      talkTitle: "There's no IF or ELSE. It's all about YOU.",
      talkDescription: "This talk is my personal story of how I decided to switch my career from Civil Engineering to iOS Development; with no previous programming experience. Following a structured timeline, I talk about some personal successes and all the fears and failures I had to overcome. Finally, I share all the lessons I learned along the way and inspire others to take action. Changing your career doesn’t mean you have failed.",
      talkURL: "https://vimeo.com/646517989"
    ),
    Conference(
      past: true,
      name: "SwiftLeeds",
      website: "https://swiftleeds.co.uk",
      dateAndCity: "October 2021 - Leeds, United Kingdom",
      talkTitle: "There's no IF or ELSE. It's all about YOU.",
      talkDescription: "",
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
      headline: "Slices: The Deep Dish Swift Podcast",
      description: "Chat with Malin and Kai about my talk at Deep Dish Swift conference, windows phones, and Croatian food.",
      url: "https://podcasts.apple.com/ca/podcast/slices-the-deep-dish-swift-podcast/id1670026071?i=1000601927719"
    ),
    Podcast(
      headline: "Do iOS Panel hosted by Antoine van der Lee",
      description: "In this panel, Tim, Jeremy and I are interviewed by Antoine and answer the questions: What can we expect of future Swift versions? Should you still learn UIKit as a new engineer?",
      url: "https://www.youtube.com/watch?v=JBGf0Pegs5E"
    ),
    Podcast(
      headline: "The Mayank Show - This is how you can become an iOS Developer",
      description: "Mayank and I talk about attending WWDC 2022 without a ticket and how someone can become an iOS Developer.",
      url: "https://www.youtube.com/watch?v=gZvGtbaDJp8"
    ),
    Podcast(
      headline: "Empower Apps - Coffee Chats",
      description: "Leo and I talk about the importance of meeting with people 1-on-1 and my experience of meeting folks at WWDC 2022.",
      url: "https://www.youtube.com/watch?v=AbK1n_WHsZM"
    ),
    Podcast(
      headline: "AppForce1 - WWDC expectations and predictions Twitter Space",
      description: "Jeroen and Stefan have hosted Mikaela, Malin, Josh, Jordi, Rudrank and me to talk about our expectations and predictions for WWDC 2022.",
      url: "https://appforce1.net/podcast/shownotes/?episode=WWDC+expectations+and+predictions+Twitter+Space"
    ),
    Podcast(
      headline: "AppForce1 - 1st a civil engineer then a software engineer",
      description: "Jeroen and I talk about my career as a software developer and why I decided to move away from Civil Engineering.",
      url: "https://appforce1.net/podcast/shownotes/?episode=Danijela+Vrzan%2C+1st+a+civil+engineer+then+a+software+engineer"
    ),
    Podcast(
      headline: "Everyday Robots - A creative mind",
      description: "Chat with Jonathan about getting into iOS Development and learning how to code. We talk about SwiftUI, UIKit, and writing articles for raywenderlich.com.",
      url: "https://everydayrobots.tech/posts/ep78/"
    ),
    Podcast(
      headline: "iOS Chats - iOS Chat with Danijela Vrzan",
      description: "In this iOS Chat, Filip and I talk about my career switch from Civil Engineering to becoming an iOS Developer, about attending first ever raywenderlich.com iOS bootcamp, and more.",
      url: "https://nemecek.be/chats/danijela-vrzan"
    )
  ]
}
