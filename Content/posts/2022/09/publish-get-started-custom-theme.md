---
date: 2022-09-05 08:45
description: After you've learned how to generate a website in Publish, before you deploy it and show it off to the world, you might want to change the default theme and create your own. Publish comes with a default theme called Foundation, but it's only for demonstration purposes and it's suggested to create a new one for your website. This post will show you how.
image: /images/posts/2022/09/publish-get-started-custom-theme.png
tags: publish, web development
---

# Publish: Getting Started with Custom Themes

So you've learned [how to create a personal website in Swift using Publish](https://danijelavrzan.com/posts/2022/06/create-portfolio-website-using-publish/) and you're ready to show it off to the world... almost!

> We'll use the website called **MyWebsite**, we created in the previous post, for this and all other posts on Publish.

Before [deploying your website](https://danijelavrzan.com/posts/2022/08/publish-deploy-to-github/) you might want to change the theme and create some custom HTML elements.

## Theme

Publish uses a default theme to render your website called **Foundation**. While you're welcome to use it, the documentations suggests that you create your own theme. Default theme is there to guide you and should be used as a point of reference for creating your own.

Under **Package Dependencies**, find **Publish** and expand it. Go to **Sources** -> **Publish** -> **API** and open **Theme+Foundation** file. At the top you'll find the foundation theme:

```swift
public extension Theme {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var foundation: Self {
        Theme(
            htmlFactory: FoundationHTMLFactory(),
            resourcePaths: ["Resources/FoundationTheme/styles.css"]
        )
    }
}
```

Theme consists of two parts. First, you have the **HTMLFactory** where you define the HTML components and create your header, navigation, footer, and other needed elements. Then, you need the **styles.css** file to style your website.

> You write your website's components in a SwiftUI-like syntax using Swift language. However, it's good to be familiar with both HTML and CSS. If you've never worked with them before, getting familiar with both and learning some basics will help you design and style your components faster.

To create your own theme, you'll need to add the above extension and define your own HTMLFactory and a CSS file.

Copy the above code and paste it in your **main.swift** file, above `.publish(withTheme:)`  line:

```swift
// Define your Theme here
...

// This will generate your website using the built-in Foundation theme:
try MyWebsite().publish(withTheme: .foundation)
```

Xcode will complain it *Cannot find FoundationHTMLFactory in the scope* and it's correct. You need to create it. But before you do that, change the name of your new HTMLFactory to whatever name you'd like. I'll name it **MyThemeHTMLFactory()**.

## Styling

To create your own custom theme, you need to create a CSS file.

The theme you defined in **main.swift** is still pointing to foundation theme's **styles.css** file and if you try and build the website, it will fail.

In your Xcode project, under **Resources**, create a new folder and name it **MyTheme**.

Now in **Package Dependencies**, find **Publish** and expand it. Go to **Resources** -> **FoundationTheme** and copy the **styles.css** file. You can open Publish in Finder and copy the file from there then paste it in the newly created folder:

![styles.css file under Resources folder in Xcode project](/images/posts/2022/09/publish-get-started-custom-theme-01.png "styles.css file under Resources folder in Xcode project")

After you copied the CSS file, make sure to update all the properties you've changed. Open **main.swift** and update the name of your theme, path to your CSS file and the theme name you're publishing your website with:

![main.swift file showing highlighted parts of code to change the custom theme name, path to resources folder of the css file and  the call to theme in publish(withTheme) method](/images/posts/2022/09/publish-get-started-custom-theme-02.png "main.swift file showing highlighted parts of code to change the custom theme name, path to resources folder of the css file and  the call to theme in publish method")

## HTMLFactory

Next, open **Theme+Foundation.swift** file under **Package Dependencies**. Below the `extension Theme` is a definition of `FoundationHTMLFactory`. Below the factory are definitions of a few of the HTML components; `SiteFooter`, `SiteHeader`, `Wrapper`, `ItemList` and `ItemTagList`. 

First, copy the HTMLFactory and all of the components. Next, create a new file in your Xcode project under **Sources** -> **MyWebsite**. Name it **MyThemeHTMLFactory** or whatever name you chose for your factory. Paste your code to this new file.

Change the name of the FoundationHTMLFactory to **MyThemeHTMLFactory** or the name of your choice. Then, import both **Publish** and **Plot** below `import Foundation` at the top of the file:

```swift
import Foundation
// Import Publish and Plot
import Publish
import Plot

private struct MyThemeHTMLFactory<Site: Website>: HTMLFactory {
...
}
```

All the errors are now gone and you're ready to customize your theme.

You can take a closer look what methods define the HTMLFactory by jumping to it's definition.

> To read the definition of a code component in Xcode, whether from a third party or Apple's API, right-click on the code you want to learn more about and click **Jump to Definition**.

```swift
/// Protocol used to implement a website theme's underlying factory,
/// that creates HTML for a site's various locations using the Plot DSL.
public protocol HTMLFactory {
    /// The website that the factory is for. Generic constraints may be
    /// applied to this type to require that a website fulfills certain
    /// requirements in order to use this factory.
    associatedtype Site: Website

    /// Create the HTML to use for the website's main index page.
    /// - **parameter** index: The index page to generate HTML for.
    /// - **parameter** context: The current publishing context.
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML

	...
}
```

There are six methods used to define the HTMLFactory. Each method defines a larger HTML component of your website, like the index page (your homepage), sections, pages, items (your blog posts), tag list and tag details.

> Tags are used to filter your blog posts by a category you specify. Publish creates an new page that has a list of all the tags you define in your blog posts. This list is generated automatically. All tags are defined in the metadata section of a blog post. We'll take a look at this in the future post.

## Standalone Components

Standalone components are smaller HTML elements you create outside of the HTMLFactory and call them in any of the makeHTML methods, depending on the use case.

For example, at the end of the file, there's a `SiteFooter()` struct that defines your website's footer:

```swift
private struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Text("Generated using ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
            }

            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}
```

These *smaller* components are created using [Plot](https://github.com/JohnSundell/Plot) framework and are of type `Component`. Plot parses the code your write into HTML for your website.

You'll notice a very SwiftUI-like syntax here. It looks very similar to creating a **SwiftUI** `View`, there are UI components like `Footer`, `Paragraph`, `Text` and `Link` inside the `body`. These are all Plot components you can use to create the UI of your website. You can find more components to use in the Plot API. 

When you create a standalone `Component` you need to call it in one of the HTMLFactory methods. Or all of them. Since `SiteFooter` is an HTML component that all the web pages of your website will have, that component is called at the end of every method. 

> The order of calling the components matters. SiteFooter is added at the end because it's the last element of a web page.

The footer is rendered like this on your website:

![Highlighted parts of website: header, body and footer](/images/posts/2022/09/publish-get-started-custom-theme-03.png "Highlighted parts of website: header, body and footer")

And the underlying HTML looks like this:

```no-highlight
<footer>
  <p>Generated using 
    <a href="https://github.com/johnsundell/publish">Publish</a>
  </p>
  <p>
    <a href="/feed.rss">RSS feed</a>
  </p>
</footer>
```

We won't go into details on every component and every makeHTML method. I've shown you how they work and now you can explore them on your own. 

## Final Thoughts

This is where things get more complex when using Publish. You have to explore on your own. You have to read both Publish and Plot API's code to figure out how to create components and how they fit together. 

There will be more posts on this topic and how to work with the CSS file as well. This is just to get you started creating your own custom theme. I suggest you explore on your own and figure things out as you go along. 

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
