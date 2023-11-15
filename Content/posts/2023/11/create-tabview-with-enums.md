---
date: 2023-11-14 08:45
description: Enums are a data type that allow you to define your own values and work with them in a type-safe way. In this article, we'll create a TabView and utilize enums to define the data we need, in a type-safe way.
image: /images/posts/2023/11/create-tabview-with-enums.png
tags: swift, swiftUI
---

# Handle TabView data in a type-safe way with Enums

Enumerations, or *enums* for short, are a data type that allow you to define your own values and work with them in a type-safe way. This greatly reduces the likelihood of unexpected and invalid states and makes your code more readable.

In this article, we'll create a `TabView` and utilize enums to define the data we need, in a type-safe way.

## Creating a TabView

Let's create a new view called **TabViewNavigation** with a `TabView` and two tab items:

```swift
struct TabNavigationView: View {
    // Persist the selected tab between app launches
    @SceneStorage("SelectedTab") private var selectedTab = "Home"

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("Home")
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag("Settings")
        }
    }
}
```

We create two tabs called **Home** and **Settings** with appropriate **SFSymbols**. Tabs have unique names, so we use their name as a tag.

This implementation works great. You can create a `TabView` like this and use it in your app without any issues. However, notice we're using raw strings in our labels and **"Home"** string is repeated three times. 

While this works, there's a better way to handle all the tab information in a type-safe way without repeating strings and calling for potential errors in your code.

## Creating a Tab enum

This is a perfect example of where to use enums in your code. Each tab in the `TabView` is a unique value. There are no two tabs with the same name.

Create a new `enum` called **Tab** with two cases:

```swift
enum Tab {
    case home
    case settings
}
```

The number of values depends on how many tabs you have.

### Handle tab data

I want to expand the enum to handle all data for the tab's `Label`. Add two computed properties; **title** and **icon**:

```swift
// Set `String` as raw value type for @SceneStorage
enum Tab: String {
    case home
    case settings

    // tab title
    var title: String {
        switch self {
            case .home:
                return "Home"
            case .settings:
                return "Settings"
        }
    }

    // tab icon
    var icon: String {
        switch self {
            case .home:
                return "house"
            case .settings:
                return "gear"
        }
    }
}
```

Here, we use switch on the enum itself and return the string depending on the value.

Both properties are of type `String` because that's what the `Label` initializer requires.

Apart from title and icon, we want to use enum to persist the selected tab with `@SceneStorage`. You need to specify `String` as the raw type for the enum so you can use it with `@SceneStorage`.

## Using Tab with TabView

Now all that's left is to rewrite the **TabNavigationView** and use `Tab` instead:

```swift
struct TabNavigationView: View {
    @SceneStorage("SelectedTab") private var selectedTab: Tab = .home

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(Tab.home.title, systemImage: Tab.home.icon)
                }
                .tag(Tab.home)
            SettingsView()
                .tabItem {
                    Label(Tab.settings.title, systemImage: Tab.settings.icon)
                }
                .tag(Tab.settings)
        }
    }
}
```

That looks better than using raw strings everywhere. It's more readable and it's type-safe as well. 

## Final Thoughts

Enums are a first-class types in Swift, and unlike in some other programming langages, can be very powerful behind the basic implementation. They can be extended to add additional functionalities as well.

Utilizing enums in your code can help you make it more readable and avoid unnecessary errors.

If you want to learn more about enums, the official [Swift documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/) is a great place to start.

***

Please feel free to reach out on [X (Twitter)](https://twitter.com/dvrzan) or [Mastodon](https://iosdev.space/@dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
