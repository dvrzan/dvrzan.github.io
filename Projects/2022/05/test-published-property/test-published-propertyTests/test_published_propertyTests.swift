//
//  test_published_propertyTests.swift
//  test-published-propertyTests
//
//  Created by Danijela Vrzan on 2022-05-02.
//

import XCTest
@testable import test_published_property
import Combine

class VideoListViewModelTests: XCTestCase {
  var sut: VideoListViewModel!
  var cancellables = Set<AnyCancellable>()
  var networkManager: MockNetworkManager!

  override func setUp() {
    super.setUp()
    networkManager = MockNetworkManager()
    sut = VideoListViewModel(networkManager: networkManager)
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_videoList_initialValue_isEmpty() {
    XCTAssertTrue(
      sut.videos.isEmpty,
      "initial value for 'videos' is not empty"
    )
  }

  func test_videos_whenAppendVideosCalled_hasThreeValues() {
    //When
    sut.appendVideos()
    //Then
    XCTAssertEqual(sut.videos.count, 15)
  }
  
  func test_videoList_whenLoadVideosCalled_hasThreeVideos_async() async {
    //Given
    let expectation = XCTestExpectation(description: "Loading videos")

    sut.$videos
      .dropFirst()
      .sink(receiveValue: {
        XCTAssertEqual($0.count, 4)
        expectation.fulfill()
      })
      .store(in: &cancellables)

    //When
    await sut.loadVideos()

    //Then
    wait(for: [expectation], timeout: 1)
  }

}
