---
date: 2023-10-04 08:45
description: Swift Algorithms is an open source package of sequence and collection algorithms. It contains many generic algorithms found in other popular programming languages. In this post, we'll take a look at how to implement the .chunked() algorithm to chunk an array of data and display it in your UI. 
image: /images/posts/2023/10/swift-algorithms-chunked.png
tags: swiftUI, swift
---

# Split your data easily and efficiently with .chunked()

[Swift Algorithms](https://github.com/apple/swift-algorithms) is an open source package of sequence and collection algorithms. It contains many generic algorithms found in other popular programming languages.

It was created by Apple engineers to help developers improve the code we write. If you write a lot of lengthy raw loops that can often get difficult to read and understand, it's very likely there is an algorithm in the package you can use instead.

Swift Algorithms package serves as a playground for algorithms to be tested in the real world. If they are valuable enough and used by a lot of developers, there is a chance they will be moved into the standard library.

In this post, we'll take a look at how to implement the `.chunked()` algorithm to *chunk* an array of data and display it in your UI. 

Swift Algorithms package can be added to your project via Swift Package Manager and imported with `import Algorithms`.

## App Example

We'll use an example app to implement the algorithm. A travel app showing a list of all the places you've visited or are planning to visit, sorted by date in descending order.

### Data Model

We'll use the following `Travel` model to display some basic information about the trip, along with the `date` the trip took place.

```swift
struct Travel: Identifiable, Hashable {
    let id = UUID()
    let country: String
    let city: String
    let date: Date
    let image: String
}
```

The struct conforms to `Hashable` so we can iterate over the elements in `ForEach` to display the data in the UI.

Then, we mock the data and create an array of travels.

```swift
extension Travel {
    static let travels: [Travel] = [
        Travel(
            country: "Maldives",
            city: "Malé",
            date: .init(timeIntervalSince1970: 1712432922), // Apr 6, 2024
            image: "male"
        ),
        ...
    ]
}
```

### List of travels

Now all you need is display the information in any way you'd like. In this example, I'm using a simple `List` that shows all my travels, including an image.

```swift
struct ContentView: View {
    var body: some View {
        List {
            ForEach(Travel.travels, id: \.id) { travel in
                HStack(alignment: .top) {
                    Image(travel.image)
                        .resizable()
                        .frame(width: 100, height: 60)
                        .scaledToFit()
                        .cornerRadius(5)
                    VStack(alignment: .leading) {
                        Text(travel.city + ", " + travel.country)
                        Text(travel.date, style: .date)
                            .padding(.top, 2)
                            .font(.caption)
                    }
                }
            }
        }
    }
}
```

The app looks like this:

![iPhone app with a screen showing a list of travel data](https://www.danijelavrzan.com/images/posts/2023/10/swift-algorithms-chunked-01.png "iPhone app with a screen showing a list of travel data")

## Chunked algorithm

Chunked algorithm has a few different variations. You can break your data into equal chunks or define a predicate, depending on the use case. 

If you want to learn more about the algorithm itself, how it works and how it's designed, check the [official documentation](https://github.com/apple/swift-algorithms/blob/main/Guides/Chunked.md) to learn more.

> It's worth mentioning the algorithm has a complexity of **O(n)** where **n** is the number of elements in the collection. It's very efficient!

### About .chunked(by:)

While it's great to see a list of all the travels in my app grouped together, it would be even better to split the list by month.

This is where `.chunked(by:)` comes into play. We can define a custom predicate to test consecutive elements in the array and it will create subsequences where the predicate is satisfied. 

It’s important to mention the collection has to be sorted for chunked to work. In the case of my app, travels are already sorted by date in descending order. If your collection of data is not sorted, remember to do that first.

### Using .chunked(by:)

We'll create `travelsChunked` to store the new collection and chunk the `travels` array by comparing consecutive dates by their month. 

```swift
static var travelsChunked: [[Travel]] {
    let chunked = travels.chunked {
        Calendar.current.isDate($0.date, equalTo: $1.date, toGranularity: .month)
    }
    return chunked.map { Array($0) }
}
```

Chunked algorithm breaks the base collection into subsequences of type `ArraySlice`.  It's what allows the chunked to be fast and efficient. `ArraySlice` has the same interface as `Array` and generally same operations can be performed on both. 

However, long-term storage of an `ArraySlice` is strongly discouraged. It holds a reference to the entire storage of the larger array and can cause memory leaks. We used `.map()` to transform it into an array instead.

Visually, it looks like this:

```
// Starting array
[January 2, January 4, January 14, May 1, September 21, April 6]

// After chunked is performed
[ [January 2, January 4, January 14], [May 1], [September 21], [April 6] ]
```

Now we have an array of arrays, grouped by month and we can implement it in our UI.

### UI Implementation

Switch the `travels` array with `travelsChunked` and add an additional `ForEach`:

```swift
struct ContentView: View {
    var body: some View {
        List {
            ForEach(Travel.travelsChunked, id: \.self) { travels in
                Section {
                    ForEach(travels) { travel in
                        HStack(alignment: .top) {
                            Image(travel.image)
                                .resizable()
                                .frame(width: 100, height: 60)
                                .scaledToFit()
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Text(travel.city + ", " + travel.country)
                                Text(travel.date, style: .date)
                                    .padding(.top, 2)
                                    .font(.caption)
                            }
                        }
                    }
                } header: {
                    Text(travels.first!.date.formatted(.dateTime.month(.wide)))
                }
            }
        }
    }
}
```

In the first `ForEach`  you get the subsequences of the `travelsChunked` array and then grab the information for each travel with the second `ForEach`.

I've used `Section` with a `header` to group travels by month, but there are other UI components you can use as well. The header has a `Text` label that displays the month of the travel. It takes the month of the first element in the array and displays it in a **wide** format, which is the full month name.

The final UI looks much better:

![iPhone app with a screen showing a list of travel data grouped by month](https://www.danijelavrzan.com/images/posts/2023/10/swift-algorithms-chunked-02.png "iPhone app with a screen showing a list of travel data grouped by month")

## Final Thoughts

You've seen how to implement one of many algorithms the Swift Algorithms package has to offer. 

What's great about implementation is how simple chunked is to use and it's only a few lines of code. It would be more complex if you wanted to implement a custom solution. You'd also have to make sure it's efficient and fast, especially when working with large collections of data.

Check out other algorithms in the package and see if you have any custom implementations in your code you can switch with an algorithm from the package instead.

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
