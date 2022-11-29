---
date: 2022-11-29 08:45
description: You use Xcode build configuration files to define all sorts of useful build settings. You can open them with different text editors outside of Xcode and all properties are in plain text. It's common to use them for managing constants across different environments.
image: /images/posts/2022/11/xcode-configuration.png
tags: swift, xcode
---

# How to manage build settings using Xcode configuration files

If you are working as part of a team in a bigger company, it's likely you have multiple environments set up. The names can be different, but these are usually a **development** environment for devs to do their work, a **testing** environment for QAs and a **production** environment.

If you are working alone, you might not have these environments set up for a smaller app. But even if you don't, you could still benefit from creating an Xcode build configuration file for different build settings.

You can open Xcode configuration files outside of Xcode and with any text editor. Because all properties are in plain text, they are easier to read and you don't have to navigate Xcode's maze of build settings.

One of the popular use-cases for using a configuration file is to manage constants across different environments. We're going to use it to store a base URL for our API.

> I suggest reading this article by [Matt](https://twitter.com/mattt) from NSHipster on [Secret Management on iOS](https://nshipster.com/secrets/). He suggests never to use Xcode Configuration files to manage your API Keys (or secrets). The best way to keep your secrets secure, is to **obfuscate** them using code generation.

Or, in the words of Julian Assange:

> *"The only way to keep a secret is to never have one."*

## Configuration Settings File

Xcode build configuration files or **.xcconfig** files allow us to define and manage build settings for our apps in plain text. Each file consists of a sequence of key-value properties in a **KEY_NAME = value** format, where value can be `String`, `Int`, `Bool`, or other defined formats. You can read more on configuration settings file format in Apple's [Xcode Help](https://help.apple.com/xcode/mac/11.4/#/dev745c5c974) documentation.

In your Xcode project, create a new **Configuration Settings File** anywhere you'd like and name it **Configuration**. Make sure not to select any targets for it.

![Configuration Settings File in Xcode](/images/posts/2022/11/xcode-configuration1.png "Configuration Settings File in Xcode")

Next, add a property for your base url to the file:

```swift
// Example:
BASE_URL = awesome.example.com
```

## Info.plist

Build settings defined by Xcode project and configuration files are only available at build time. When you compile the app, none of it is available. As it should be.

After creating the **BASE_URL** property, you need to add it to your **Info.plist** file. It'll get compiled during build time based on the build settings provided and copied into the app bundle.

But wait, there's no **Info.plist** file in Xcode. Following Xcode 13 release, there's no **Info.plist** file by default anymore when you create a new project in Xcode. This file is a feature and only created when needed. We're nudged to use Xcode's Build Settings instead.

Select your project in Xcode and go to **Info** tab. Expand **Configurations** and add your **Configuration.xcconfig** file to both **Debug** and **Release**. We only have a single configuration file, but this is where you can set up different configuration files for different environments:

![Adding Configuration file in Info settings](/images/posts/2022/11/xcode-configuration2.png "Adding Configuration file in Info settings")

Now all that's left to do is to add a reference to the property in target's build settings.

## Custom iOS Target Properties

By adding a reference to the configuration properties, you can access their values with Foundation's `Bundle` API.

Select your project's target in Xcode and go to **Info** tab. Select any property in **Custom iOS Target Properties** and click on the **+** button to add a new property.

Add **BASE_URL** with the reference to your configuration property **$(BASE_URL)**:

![Custom iOS Terget Properties](/images/posts/2022/11/xcode-configuration3.png "Custom iOS Terget Properties")

After adding the property, an **Info.plist** file gets added to your project automatically. All your custom user properties will get stored here.

Now all you have to do is access the base url in your code.

## Bundle

Create a new **Swift** file and name it any way you'd like. I'll name it **Environment**. Add the following code to the file:

```swift
import Foundation

public struct Environment {
// Define the properties
    enum Keys {
        static let baseURL = "BASE_URL"
    }
    // Get the BASE_URL
    static let baseURL: String = {
        guard let baseURLProperty = Bundle.main.object(
			forInfoDictionaryKey: Keys.baseURL
		) as? String else {
            fatalError("BASE_URL not found")
        }
        return baseURLProperty
    }()
}
```

Here you create a new **Environment** `struct` and a **Keys** `enum` that defines all your custom keys. Then you create a **baseURL** constant to get the value from the bundle. Now you have access to its value where needed.

Let's print it out in a View to make sure it's working:

![Base url printed out in a View](/images/posts/2022/11/xcode-configuration4.png "Base url printed out in a View")

## Final Thoughts

Xcode build configuration files are quite useful to manage configuration properties between different environments. You can also use them to easily assing a different app name and an app icon for specific environment.

What makes them especially useful is you can open them outside of Xcode with any text editor. It also keeps your configuration properties outside of your code.

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!