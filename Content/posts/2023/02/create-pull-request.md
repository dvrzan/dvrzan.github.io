---
date: 2023-02-07 08:45
description: Creating an reviewing pull requests (PRs) is an everyday part of our work. Why don't make it easier and more enjoyable for others reviewing your work? Your colleagues will thank you for it! Learn here how you can improve your pull requests in 5 tips.
image: /images/posts/2023/02/create-pull-request.png
tags: non-technical
---

# 5 Tips to creating a (good) pull request

You've finally got all your unit tests to pass and you're satisfied with the work you've done on your ticket. The UI is pixel-perfect and even your designer says you've done a great job with the assets they gave you. You've tested the UI and it works without any issues. You feel very proud.

You're ready to show off your work to your colleagues. You create a PR and patiently await their comments and approval. Days go by and no approvals yet. Not a single comment.

Maybe your PR is too big and no one's had time to review it yet. Or it's missing important parts and no one was able to understand it, so they glanced and postponed reviewing it.

> If you don't know what a pull request or a PR is, I suggest you read more [About pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) in GitHub Docs.

## 1. Keep it short

Reviewing other people's PRs is already hard enough without having to go through hundreds, possibly thousands of lines of code. Try to make your PRs as short and on point as possible. 

Most likely your PR will be tied to the ticket you're working on and will only require you to do the work as part of that ticket. Don't go around fixing other code and potentially making your PR large and out of scope of your current work. Not only does it make your PR bigger, it makes it harder to read because there's no story to the work you've done. 

Treat your PR as a short story. It has just enough information to read it in a single sitting without getting bored halfway through.

## 2. Add more information 

Depending how the process is set up in your company or your team, you might already have a default template set up when creating new PRs. They are very useful and can help a great deal in explaining the background of the work you've done. Remember, not everyone may know what your PR is about, so add some background to the story. 

### What and Why
Introduce the characters and give the summary of what and why.

What is the ticket about and why do we need it? No one is going to search for your ticket and read the requirements to learn what you're trying to do. 

How did you implement the requirements? Add all the necessary information a person may need before they take a look at your code. Write the reason behind the work and explain any technical decisions you made. You want the person reading your PR to understand why you did what you did. I've seen too many reviewer comments asking a developer to change their approach when something was done for a specific reason.

But, don't get into too much detail and be specific. Add only relevant information. Think about what you'd want to see when you're reviewing someone else's PR.

### Screenshots or gifs of before and after
Add images where appropriate. Everyone loves images. If you're working on something that adds a new or changes an existing UI component, add a screenshot or a gif in the description. No one knows how something looks like by reading the code. You might think you've copied the design assets perfectly when you might have chose an incorrect shade of blue or forgot to round the corners. 

If you're fixing an issue, add an image of **before** and **after** so others know what you've changed. If you're creating a new component add a **design asset** vs **your working implementation**. 

> TIP: You can add images in a table with two columns. One for *before* and one for *after* or any other use case. It's neat to see them side by side.

### Link other relevant PRs 
Does your PR require code change in another repository? If you had to make more than one PR for the work you've done, link them all in the description. It's much easier and faster to click on the link that leads to all other relevant PRs that hunting them down.

## 3. Leave in-line code comments
This is something I like to do. 

If I've implemented or wrote something in a specific way for a reason but it wouldn't make sense for a person reading my code, I'll leave a comment on that line of code in the PR. Maybe I've talked to a designer or a technical architect and we've agreed on an approach. You have to remember that people who haven't worked with you on a specific problem don't have any outside context. 

It will especially help those "*you could've used this, instead of this*" comments.

## 4. Assign people or groups as reviewers
Don't leave your PRs out there in the wild and hope someone will see them. Remember to assign them to relevant people, or groups if you have that set up. You'll get a review much sooner.

## 5. Let your colleagues know your PR is ready for review
Apart from assigning reviewers, write a line in your team's chat letting everyone know there's a PR ready for their review. You could create a channel for this purpose only. It's likely someone will see the chat notification sooner than an e-mail one. 

## Final Thoughts

Be mindfull of the time your colleagues have to spend reviewing your PRs. Be a good colleague and show them you care about the time they put into reviewing your code and make their job easier. They will thank you for it.

One more thing. Never take comments on your code too personal and don't be passive aggressive when reviewing other people's PRs. Remember - no one knows everything.

*"It's nice to be important, but it's more important to be nice."*

***

Do you have any other tips on writing a good pull request? Let me know, I'd be interested to learn more about your thoughts!

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy reviewing!
