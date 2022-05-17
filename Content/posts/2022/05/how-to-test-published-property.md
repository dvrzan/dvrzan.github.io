---
date: 2022-05-17 08:45
description: @Published properties stream values over time and any changes on the property are immediately sent to all observers. Let's recap how the property works and then we'll take a look at how we can test @Published properties using Apple's testing framework - XCTest. 
image: /images/posts/2022/05/how-to-test-published-property.png
tags: unit test, combine
---

# How to test @Published property with XCTest

How you're testing a functionality of your code depends on what you want to test and understanding how the code works. Let's start with a quick recap of `@Published` property.

## @Published property

`@Published` properties stream values over time. When the property's marked as `@Published` it gets assigned a `willSet` observer. Any changes on the property are immediately sent to all observers.

```swift
class VideoListViewModel {
  @Published var videos = [Video]()
}
```

Observers are views that watch for any upcoming changes on the property to decide if they need to redraw themselves to display newest data. For view to receive any upcoming updates, you need to mark the object you want to observe with `@ObservedObject`.

```swift
struct ContentView: View {
  @ObservedObject var viewModel: VideoListViewModel

  var body: some View {
    ...
  }
}
```

Then any type marked as `@ObservedObject` needs to conform to **ObservableObject** protocol. Conforming to this protocol creates an `objectWillChange` publisher. It allows observes to watch for any future changes to its `@Published` properties.

```swift
class VideoListViewModel: ObservableObject {
  ...
}
```

## Testing current value with direct access

`@Published` property is still ***just*** like any other property and we can get its current (wrapped) value by asking for it directly.

One of the use cases here is to test the initial value of the property. 

```swift
func test_videos_initialValue_isEmpty() {
  let viewModel = VideoListViewModel()

  XCTAssertTrue(
      viewModel.videos.isEmpty,
      "Expected initial value to be empty, but got \(viewModel.videos)."
  )
}
```

Another use case is testing a synchonous operation. A simple example would be to append new values to **videos** array with `.append(_:)`. 

```swift
func appendVideos() {
  videos.append(Video(name:"My First Video"))
  videos.append(Video(name:"My Second Video"))
  videos.append(Video(name:"My Third Video"))
  videos.append(Video(name:"My Fourth Video"))
  videos.append(Video(name:"My Fifth Video"))
}
```

You can assert property's current value after the function gets called. The operation will complete before the assertion. 

```swift
func test_videos_whenAppendVideosCalled_hasFiveVideos() {
  //Given
  let viewModel = VideoListViewModel()
  //When
  viewModel.appendVideos()
  //Then
  XCTAssertEqual(viewModel.videos.count, 5)
}
```

The whole point of `@Published` properties is to stream any changes to the view before the value is set. It's like giving someone a heads up something will happen before it does. In that case, you'd want to test the values sent to the view.

## Testing published value by subscribing to it

`@Published` properties stream values over time. To get the published (projected) value of the property, you need to subscribe to it with `.sink(receiveValue:)`.

> While word **sink** might sound confusing at first, it's a common math term. It's often used in engineering and refers to end location of anything that flows (water, data, time, heat etc.). **Source** is where the flow starts and **sink** is where the flow ends.
>
> In graph theory, sink is a node of a directed graph with no exiting edges; meaning all directed edges flow towards it.
>
> In **Combine**, reactive stream flows towards `.sink(receiveValue:)`. 

To fetch data for the `@Published` property you'll likely have an asynchronous operation, so you need to use test expectations.

```swift
func test_videos_whenFetchVideosCalled_hasFourVideos() async {
  //Given
  let viewModel = VideoListViewModel()
  let expectation = XCTestExpectation(description: "Publishes 4 videos")

  sut.$videos
    // Remove the first (initial) value - we don't need it
    .dropFirst()
    .sink(receiveValue: {
      // Assert there are 4 new values
      XCTAssertEqual($0.count, 4)
      // Fulfill the expectation
      expectation.fulfill()
    })
    .store(in: &cancellables)

  //When
  await sut.fetchVideos()

  //Then
  wait(for: [expectation], timeout: 1)
}
```

These two examples are common use cases of how you can approach testing your `@Published` properties. There may be more complex use cases and it all depends on your code. I hope this gives you an idea and a good starting point. 

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback. These blog posts come from my own learning and sharing what I've learned with everyone, in hope it can help you where I've struggled. We're all learning and trying to be better developers every day. Constructive feedback is most welcome.

Thank you for reading and happy coding!
