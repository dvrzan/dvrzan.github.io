//
//  ContentView.swift
//  test-published-property
//
//  Created by Danijela Vrzan on 2022-05-02.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = VideoListViewModel(networkManager: NetworkManager())

  var body: some View {
    List {
      ForEach(viewModel.videos, id: \.self) { video in
        Text(video.name)
      }
    }
  }
}
