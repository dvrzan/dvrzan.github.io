---
date: 2022-10-17 08:45
description: You're working on your website and making changes, but nothing has changed. You refresh the browser and yet nothing happens. In this post, learn how to use the tools available to refresh your website and see the changes you've made, applied instantly.
image: /images/posts/2022/10/publish-automatic-local-changes.png
tags: publish, web development
---

# Publish: How to Preview Local Changes on Your Website Instantly

You've decided to [create a website in Swift using Publish](https://danijelavrzan.com/posts/2022/06/create-portfolio-website-using-publish/) and you're working locally on your machine. You're making local changes before you deploy a new version or publish a new post. 

While you're working on the website, you make a change, run the build, and for some reason the changes are not applied. You run the build again and nothing happens. You're not sure anymore if what you're doing is correct or is there another issue. There *is* another issue. 

Your website is **cached** and changes take a long time to update. That includes any local changes. 

You'll see how to fix this issue in an easy way and see the changes you've made *almost* automatically. It's not SwiftUI Previews, but close enough.

## Browser Cache

Web browsers cache resources from websites you visit in a small database of files. Common resources in a browser cache are images, text, HTML, CSS, and Javascript.

This data is stored on your computer and a browser doesn't know if you're looking at an online or a local server content. Resources are stored anyway. This is why when you open your **http://localhost:8000** website, HTML and CSS get cached. When you make a change and refresh the browser, the changes may not show right away. 

Let's take a look at how to fix this issue.

## Google Chrome

Whether you're already using it, or not, Chrome is the first choice for testing websites in web development. Their **Developer Tools** are the best out there. This is what you'll use to fix the issue and finally be able to see your new changes with a simple refresh.

In Chrome, go to **View** -> **Developer** -> **Developer Tools** or **Option+Command+I** as a shortcut. There'll be a new panel at the bottom of the browser:

![Google Chrome web browser with Developer Tools opened](/images/posts/2022/10/publish-automatic-local-changes01.png "Google Chrome web browser with Developer Tools opened")

You'll need to open Tools every time you're working on your website so you'll remember the shortcut quite fast. Tools close automatically when you close the browser.

Developer Tools are a very powerful toolkit to inspect website elements, see web traffic, and do a lot of other things we won't be getting into details now. We're interested in turning off the cache so we can see the changes we make during development.

In Developer Tools, find the **Network** tab at the top and click on **Disable cache** below it:

![Network tab in Developer Tools with cache disabled](/images/posts/2022/10/publish-automatic-local-changes02.png "Network tab in Developer Tools with cache disabled")

When you disable cache in Developer Tools, this setting with persist across browser launches, but it will only apply when the Tools are open. This won't mess with the regular use of your browser.

Now every time you're working on your website and want to see the change you make in the code, run the build in Xcode and **Command+R** to refresh the page and see your changes instantly.

## Safari and Other Browsers

I personally prefer using Chrome during development, but if you'd like to use other browsers, they all have some type of developer tools. 

In Safari, it's called **Web Inspector** and can be found under **Develop**, or opened with the same shortcut **Control+Command+I**.

Then under **Network** tab, you'll find the same **Disable cache** option on the right side of the panel:

![Network tab in Web Inspector with cache disabled in Safari](/images/posts/2022/10/publish-automatic-local-changes03.png "Network tab in Web Inspector with cache disabled in Safari")

## Final Thoughts

All that's left to do now is make some changes, run the build, and refresh the page. Your website will update instantly. 

There might be other ways out there to achieve this, but I've found this works quite well.

While Publish does allow us to build websites using Swift, it still requires some knowledge of web development. I hope your website development process will now become faster and more enjoyable. 

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
