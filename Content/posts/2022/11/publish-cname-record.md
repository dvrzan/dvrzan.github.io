---
date: 2022-11-15 08:45
description: To configure custom domain for websites hosted on GitHub Pages, your repository needs to contain a CNAME record file. You can add the file manually through GitHub, but it gets overwritten after deployment. Publish force pushes to the repository and overwrites the content. In this post, learn how to persist the CNAME record and make sure it never gets deleted.
image: /images/posts/2022/11/publish-cname-record.png
tags: publish, web development
---

# Publish: Persist CNAME record when deploying with GitHub Pages

> If you want to learn how to deploy your website on GitHub Pages, check the [Publish: Deploying your website on GitHub Pages](https://danijelavrzan.com/posts/2022/08/publish-deploy-to-github/) post. Or if you're looking to get started using [Publish](https://github.com/JohnSundell/Publish), check the [How to Create a Personal Website in Swift using Publish](https://danijelavrzan.com/posts/2022/06/create-portfolio-website-using-publish/) post. 

So you bought a shiny new domain and deployed your website on GitHub Pages for the world to see. Everything works as expected, until a friend of yours messages you about a typo in the *about me* section and you stumble fast to deploy a fix. 

However, after deploying your website again, it's not working. Uh-oh. You try to revert the changes you made, to the state where everything worked, but that doesn't fix the issue.

## Custom Domain on GitHub Pages

> This post won't go into details about creating or setting up custom domains. I assume you already have one and it's set up to use. Check this article if you want to learn more about [Custom Domains and GitHub Pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages).

When you set up your custom domain for the first time, it works like a charm. However, any other subsequent deployment overwrites the setup. Your website stops working on **amazingdeveloper.com** and reverts back to using the default **yourUsername.github.io**  domain.

Then you realize after deploying your website with `publish deploy`, the **Output** folder gets overwritten and the **CNAME** record that was added manually through GitHub gets deleted. Your website no longer uses your custom domain, but reverts back to a default one.

> A **Canonical Name record** (or **CNAME record**) is a resource record in the [Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System") (DNS) that maps one domain name (an alias) to another (the canonical name).

There's a section in GitHub Docs under [CNAME Errors](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-custom-domains-and-github-pages) that explains how some static site generators work:

*"For your site to render at the correct domain, make sure your _CNAME_ file still exists in the repository. For example, many static site generators force push to your repository, which can overwrite the _CNAME_ file that was added to your repository when you configured your custom domain."*

## Quick Fix on GitHub

You can fix this quickly by opening your repository on GitHub and going to **Pages** section. Under **Custom domain**, add the missing domain:

![GitHub Pages settings section and Custom domain setup](/images/posts/2022/11/publish-cname-record1.png "GitHub Pages settings section and Custom domain setup")

When you add your custom domain, GitHub automatically adds a **CNAME** record to the root of your **Output** folder. 

While this does fix the issue, it's not a permanent solution. You'd have to do it manually every time you deploy a new change to your website. 

And there's a better solution.

## Add CNAME to Resources

You can't persist the **CNAME** record on the GitHub repository itself, because Publish force pushes and overwrites the content. You can't add it to the **Output** folder in Xcode either, because when Xcode runs the build, it overwrittes the content of the folder every time as well. If you try adding it, when you run the build, it will get deleted.

But, there is a way to persist the file on every build and make sure it gets pushed to your repository on every deployment. You need to add the **CNAME** record to the **Resources** folder. And you only need to do this once.

One of the publishing steps in the publishing pipeline in `main.swift` file is called `.copyResources()`. Inspecting this method, tells us its purpose is to *"copy the website's main resources into its output folder"*. Exactly what we need.

In Xcode, create a new **Empty** file and add it to the root of your **Resources** folder. Rename it to **CNAME**. Make sure to name it exactly like that, all uppercase, or it won't work:

![Adding a new empty file type in Xcode](/images/posts/2022/11/publish-cname-record2.png "Adding a new empty file type in Xcode")

Then, add your custom domain on the first line, in the format of **domainname.com**. 

Now every time you run the build in Xcode, the content of the **Resources** folder is copied to the **Output** folder, including your new **CNAME** file. 

When you deploy your website, the file will push to your website's repository and GitHub will persist your domain on every deployment. Much better than doing it manually every time.

## Final Thoughts

I hope this small tip improves your experience working with Publish and GitHub Pages. 

GitHub Pages are easy to set up and Publish has a built-in deployment method for it. It's more than enough to use for personal websites that might not change in content, or small blogs. And it's free!

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
