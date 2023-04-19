---
date: 2023-04-19 08:45
description: Typing your login credentials manually during development takes away your time and focus. If you make a lot of small changes and need to check them often, that's a lot of time spent on the login screen. Set up a breakpoint in Xcode instead and speed up your development time.
image: /images/posts/2023/04/login-xcode-breakpoint.png
tags: xcode
---

# Skip typing your login credentials manually with Xcode breakpoints

You're working on your app and you want to see if your changes look good. You run your app on the Simulator and you're presented with a login screen. You type in your testing credentials and navigate to the screen you want to see. It doesn't look quite good. Repeat the process.

You have to enter your login credentials every time you run your app to get past the login screen. That can get annoying very quickly.

In some cases, you can implement logic to skip the login screen entirely during development. But sometimes, you need to log in.

## Xcode breakpoints

Xcode breakpoints are an awesome tool we have at our disposal for all things debugging. But, they can also help us speed our development process.

With Xcode breakpoints you can set up your login credentials during development so you don't have to type them manually every time you run your app.

## Sample login code in SwiftUI

I'm using a sample login screen with two `TextFields` presented as a full screen modal. When the app launches with an `initiateLogin()` it dismisses the modal screen if text fields contain correct credentials. 

Here's the code in case you'd like to try it out for yourself.

**LoginView.swift**
```swift
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Image(systemName: "person")
                TextField("Enter username", text: $username)
            }
            HStack {
                Image(systemName: "key")
                TextField("Enter password", text: $password)
            }
            Button("LOG IN") {
                // BREAKPOINT HERE
                initiateLogin()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }

    // Login Function
    func initiateLogin() {
        if username == "Danijela" && password == "123456!" {
            // Short pause - dismiss is too fast
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                dismiss()
            }
        }
    }
}
```

**ContentView.swift**
```swift
import SwiftUI

struct ContentView: View {
    @State private var isPresented = true

    var body: some View {
        VStack {
            Text("Hello! You've successfully logged in.")
        }
        .onAppear {
            isPresented = true
        }
        .fullScreenCover(isPresented: $isPresented) {
            LoginView()
        }
    }
}
```

## Create a breakpoint

Create a breakpoint on the login button's action. When you tap the login button you'll be automatically logged in without having to type the credentials manually.

Right-click on the breakpoint and click **Edit Breakpoint...**

You can give the breakpoint a name if you'd like. Under **Action** click **Add Action** and this will add a new **Debugger Command** field. Click on **+** to add another action.

These two actions will populate the text field with correct credentials.

In the first action, add `expr _username.wrappedValue = "[USERNAME]"`. In the second one, add `expr _password.wrappedValue = "[PASSWORD]"`. Change the username and password strings to match your login credentials.

Because both  `username` and `password` are `@State` properties, you need to directly access their values using [wrappedValue](https://developer.apple.com/documentation/swiftui/state/wrappedvalue) to pass the data to the text fields.

Make sure to check the **Automatically continue after evaluating actions** so your app continues executing after the breakpoint. You don't want to pause the execution of your app here.

![Xcode edit breakpoint window](https://www.danijelavrzan.com/images/posts/2023/04/login-xcode-breakpoint-01.png "Xcode edit breakpoint window")

That's it! Now run the app, tap the login button and your login credentials will populate automatically. 

![Login button populates credentials automatically](https://www.danijelavrzan.com/images/posts/2023/04/login-xcode-breakpoint-02.gif "Login button populates credentials automatically")

It's likely you'll use the same credentials when working on something in your app, so this saves you a lot of typing time. If you need to use different credentials and you know you'll have to type them in multiple times, just change their values in the breakpoint.

## Breakpoint expressions in UIKit 

If you have a UIKit app with `UITextField`, your breakpoint looks a bit different. Instead of using the `wrappedValue` you need to use the `.text` value of the text field. 

![Xcode edit breakpoint window](https://www.danijelavrzan.com/images/posts/2023/04/login-xcode-breakpoint-03.png "Xcode edit breakpoint window")

## Log in automatically without tapping the button

Another option is to login automatically without tapping the login button. 

You want the login to trigger when the view appears so you don't have to tap any buttons. The login will complete and you'll be automatically logged in. Create a breakpoint in the `viewWillAppear()` for UIKit app or `.onAppear()` for SwiftUI app of your login view. 

Next, add the third **Debugger Command** field to your breakpoint with `expr initiateLogin()`, changing the method call to your method's name. 

Open your app and when the login screen appears, it will populate the text fields and trigger the login method. You'll log in without typing anything. That's it.

## Final Thoughts

I like to reduce doing things manually as much as I can. It helps speed up my development time and I have less things to think about. 

I've learned this cool tip recently and wished I knew about it sooner! All those times I had to type in the credentials manually...

Hope you like this cool tip that will help you save some time! Do you have any tips like this you use in your everyday work? I'd love to hear about it!

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
