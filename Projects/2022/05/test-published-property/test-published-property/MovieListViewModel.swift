//
//  MovieListViewModel.swift
//  test-published-property
//
//  Created by Danijela Vrzan on 2022-05-02.
//

import Foundation

struct Video: Codable, Hashable {
  let name: String
}

class VideoListViewModel: ObservableObject {
  @Published var videos = [Video]()
  let networkManager: NetworkAPI

  init(networkManager: NetworkAPI) {
    self.networkManager = networkManager
  }

  func appendVideos() {
    videos.append(Video(name:"1"))
    videos.append(Video(name:"2"))
    videos.append(Video(name:"3"))
    videos.append(Video(name:"4"))
    videos.append(Video(name:"5"))
    videos.append(Video(name:"6"))
    videos.append(Video(name:"7"))
    videos.append(Video(name:"8"))
    videos.append(Video(name:"9"))
    videos.append(Video(name:"10"))
    videos.append(Video(name:"11"))
    videos.append(Video(name:"12"))
    videos.append(Video(name:"13"))
    videos.append(Video(name:"14"))
    videos.append(Video(name:"15"))
  }

  func loadVideos() async {
    await fetchStudentList()
  }

  private func fetchStudentList() async {
    guard let url = URL(string: "https://hp-api.herokuapp.com/api/characters/house/slytherin") else {
      return
    }
    do {
      videos = try await networkManager.fetchVideos(from: url)
    } catch {
      print(error)
    }
  }
}
