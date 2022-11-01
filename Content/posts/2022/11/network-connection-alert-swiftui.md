---
date: 2022-11-01 08:45
description: Implementing network connectivity monitor doesn't require a lot of code. But it can mean a lot between a happy and a frustrated user.
image: /images/posts/2022/11/network-connection-alert-swiftui.png
tags: swift, swiftUI
---

# How to check for network connection and present an alert in SwiftUI

Most apps use some type of networking in their code. Whether you're handling user accounts or fetching data from a remote server, you need to handle network connection issues gracefully. Not *just* making sure your app doesn't crash with a fatal error, but displaying a proper information back to the user. 

## NWPathMonitor

To check for and react to any changes in network connectivity you can use the **NWPathMonitor** observer from the **Network** framework. You can initialize the path monitor with different properties, such as specifying the type of connection (wifi, cellular...) or whether it's restricted by low data. You can check the [official documentation](https://developer.apple.com/documentation/network/nwpathmonitor) for more information. 

In this example, we'll initalize the path to observe all available interface types (wifi, cellular, wired and other).

## NetworkMonitor

Create a new **NetworkMonitor** class with the following code:

```swift
class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
```

NetworkMonitor conforms to @ObservableObject protocol so we can listen for any changes and update the UI accordingly. 

First, create two private properties, an `NWPathMonitor` observer and a `DispatchQueue` where the monitor will do its work. The third property is a `Boolean` value we'll call in the View to check for network connectivity. The initial value is **false**. 

Next, create an initializer and call the `.pathUpdateHandler` on the path monitor to handle the changes. Update `isConnected` to **true** when the path status is satisfied (connection is available) and notify observers for any changes with `objectWillChange.send()`. 

Finally, start the monitoring on the specified queue.

> Our network monitor uses a Combine publisher so it can be used in both UIKit and SwiftUI views.

Now the fun part.

## Inject into SwiftUI environment

To use network monitor in your app, instantiate it in the `@main` app struct and inject as an environment object:

```swift
@main
struct MyApp: App {
    let networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
        }
    }
}
```

Then you call it anywhere in your app. 

## Update UI

There are a few options for displaying different views and alerts when network connection is unavailable. It depends on the requirements of your app and the design of your UI. Most apps update the view displaying the *no network connection* text on the view itself. 

First, you need to call the environment object in the view:

```swift
struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    ...
}
```

### Change the View

Instead of having an empty screen when network connection is unavailable, you can create and show a different view. Something like this:

```swift
struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        NavigationView {
	        // If monitor detects valid network connection
            if networkMonitor.isConnected {
	            // Show home view
                HomeView()
            } else {
	            // Otherwise, show something else
                NoNetworkView()
            }
        }
     }
}
```

> You can test network connection in the Simulator by setting your laptop's internet off. But it doesn't work well. It doesn't detect network issues consistently and it may not present the view when you turn off your internet. I suggest testing on a real device. 

Turning your internet on and off will update the UI automatically:

![Left: view displayed with the valid network connection. Right: No network connection view with unavailable connection](/images/posts/2022/11/network-connection-alert-swiftui1.png "Left: view displayed with the valid network connection. Right: No network connection view with unavailable connection")

### Present an alert

Another way of letting the user know their network connection is offline is by presenting an alert on the screen. Instead of changing the view, you can display an alert.

> Some apps display both. If you only present an alert, your view will still be empty once the alert is dismissed. Present an alert to get user's attention and still have the *"no network connection"* text on the view.

First, you need to create a property that will determine whether to display the alert with the default value of **false**:

```swift
struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false
    ...
}
```

Then, add `.alert()` and `.onChange(of:)` modifiers on the view:

```swift
struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false

    var body: some View {
        NavigationView {
            HomeView()
        }
        .onChange(of: networkMonitor.isConnected) { connection in
            showNetworkAlert = connection == false
        }
        .alert(
            "Network connection seems to be offline.",
            isPresented: $showNetworkAlert
        ) {}
    }
}
```

Alert listens to **showNetworkAlert** binding for changes so it knows when to present. `onChange(of:)` listens for changes in the network connectivity and updates the alert's binding depending on the network status. 

The UI will look like this:

![Left: view displayed with the valid network connection. Right: Alert presented on the view with unavailable connection](/images/posts/2022/11/network-connection-alert-swiftui2.png "Left: view displayed with the valid network connection. Right: Alert presented on the view with unavailable connection")

### Present a popover

There's not much change in code to display a popover. Both alert and popover use binding to listen for changes. Replace an alert with a popover:

```swift
struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false

    var body: some View {
        NavigationView {
            HomeView()
        }
        .onChange(of: networkMonitor.isConnected) { connection in
            showNetworkAlert = connection == false
        }
        .popover(isPresented: $showNetworkAlert) {
            Text("Network connection seems to be offline.")
        }
    }
}
```

The UI will change to this:

![Left: view displayed with the valid network connection. Right: A popover presented on the view with unavailable connection](/images/posts/2022/11/network-connection-alert-swiftui3.png "Left: view displayed with the valid network connection. Right: A popover presented on the view with unavailable connection")


## Final Thoughts

Implementing network connectivity monitor doesn't require a lot of code. But it can mean a lot between a happy and a frustrated user.

Crafting delightful user experiences is part of what we do every day and also the reason why users keep coming back to our apps. We want them to come back.

You can have the best error handling code in your app and still have users leaving 1* reviews titled *"sucks"*. Where there should have been an amazing UI, was an empty screen, because, well, the user didn't realize their network connection was lost or the server decided to become a [teapot](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/418). 

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
