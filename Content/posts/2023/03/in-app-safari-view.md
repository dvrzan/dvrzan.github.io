---
date: 2023-03-21 08:45
description: In SwiftUI, you can use Link to let the user open a website in their default web browser. But sometimes you want them to stay in your app; to read privacy policy or similar. In that case, you have different options to present web content without the user ever leaving your app. 
image: /images/posts/2023/03/in-app-safari-view.png
tags: swift, swiftUI
---

# Display in-app web content with SFSafariViewController in SwiftUI

You can use `Link` to let users open a website in their web browser, outside of your app. But sometimes you want to present web content and don't want the users to leave your app. 

To implement this feature, we have two available APIs: [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) and [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller). Which one you choose, depends on the experience you want to provide.

`WKWebView` is part of the **WebKit** framework. It allows you to embed web content into your app. You can embed entire views or parts of your UI. Use it when you need to incorporate web content into your app alongside your app's native views. It's flexible and highly customizable. If you have to assign a custom user agent, then this API is for you.

`SFSafariViewController` is part of the **SafariServices** framework. It allows you to present a website from within your app. Users will never leave your app and they get the same experience as if they were using Safari, including password auto-fill and all security Safari provides. Use it when you need to display websites you don't own or present parts of web content that's out of scope of your app.

> Always make sure the view controller is visibly present and never track users without their consent or you'll be in violation with the [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/). 

In this article, you'll learn how to use the latter.

## Wrap the View Controller

`SFSafariViewController`, as the name suggests, is a **UIKit** component. To use it in your SwiftUI app, you need to create a view that represents a UIKit view controller by implementing the  `UIViewControllerRepresentable` protocol.

First, import **SwiftUI** and **SafariServices** frameworks. Create the **SafariViewWrapper** and conform to the `UIViewControllerRepresentable` protocol. Implement the required methods:

```swift
import SwiftUI
import SafariServices

struct SafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<Self>
    ) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: UIViewControllerRepresentableContext<SFSafariViewWrapper>
    ) {}
}
```

Since you're only presenting a website, in the `makeUIViewController(context:)` method you return the `SFSafariViewController(url:)` and pass the **url** as an argument. 

`updateUIViewController(_ :context:)` is required for protocol conformance, but we don't need to do any updates so we can leave it empty. You're only presenting a website, in this case.

## SafariView

You can call the `SafariViewWrapper` directly, but I like to create a reusable View component because it's likely I'll need to use it multiple times.

Create a **SafariView** with `showSafari` state property and pass in the `title` and `url`:

```swift
import SwiftUI

struct SafariView: View {
    @Binding var showSafari: Bool
    var title: String
    var url: String
    
    var body: some View {
        Button(title) {
            showSafari = true
        }
        .popover(isPresented: $showSafari) {
            SafariViewWrapper(url: URL(string: url)!)
        }
    }
}
```

You create a **Button** with a title that updates the presentation state of the popover when the user taps on it. You can also present the website as a full screen cover, but in this example, I'm using a modal popover.

Finally, you can implement it in any View:

```swift
SafariView(
    showSafari: $showSafari,
    title: "My Website",
    url: "https://www.danijelavrzan.com"
)
```

Add the `@State private var showSafari = false` at the beginning of your view to pass in the state to the child view to present the popover. Give the link an appropriate title and a url.

When you tap the link, you'll see the website inside your app.

![In-app website popover presented using the SFSafariViewController](https://www.danijelavrzan.com/images/posts/2023/03/in-app-safari-view-01.png "In-app website popover presented using the SFSafariViewController")

## Final Thoughts

At the time of writing, there's no SwiftUI way of presenting an in-app web view so we have to resort to using UIKit APIs. But using them interchangeably is not a big task. They pair nicely with each other. 

You can wrap any UIKit controller into a SwiftUI view and vice versa.

If you're interested in learning more how you can use both SwiftUI and UIKit to build responsive UIs, this talk from [Adam Bell](https://twitter.com/b3ll) at iOS Conf SG 2023 is a good watch: [Building Responsive Interactions](https://www.youtube.com/watch?v=Vbpr9xp7XKk).

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
