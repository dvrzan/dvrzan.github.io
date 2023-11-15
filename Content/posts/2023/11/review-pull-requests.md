---
date: 2023-11-01 08:45
description: Creating PRs is an easy task. Creating good PRs requires time and effort. Reviewing them, on the other hand, is something completely different. Here are some things you should look for when reviewing other people's PRs.
image: /images/posts/2023/11/review-pull-requests.png
tags: non-technical
---

# Effective pull request reviews

Creating PRs is an easy task. Creating *good* PRs requires time and effort. Reviewing them, on the other hand, is something completely different. 

> If you're new to PRs (pull requests) or would like to read more on how to create a good pull request, I suggest starting with [5 Tips to creating a (good) pull request](https://www.danijelavrzan.com/posts/2023/02/create-pull-request/).

Code reviews are all about getting a second opinion on your code and a good place to catch any potential issues. They are also a great learning opportunity. Someone might suggest a different approach you might not have thought about before.

Let's see what are some things you should look for when reviewing other people's code. Or what you can do to make sure the code quality is consistent throughout the codebase. Or even better, try to improve it.

## Approaching the review

There are two sides to any PR; the PR author and the reviewer. 

In this post, we'll take a look at how to approach reviewing the PR. However, it's worth mentioning that both sides are equally responsible on how they approach the review process. 

Written communication often lacks tone and context. Reviewers can use positive language and emojis to make their comments sound friendly. But even that can be misunderstood if you're on the receiving side. Consider the intention behind the words and don't jump to conclusions about the reviewer's attitude.

Whenever you're reading someone else's comments on your work, never assume bad intentions. Not only during PR reviews, but in general. If someone is being mean on purpose, call them out. A mean person is always mean and that doesn't go unnoticed in the team. But that's a different issue altogether.

## Your tone and language

When approaching the review, consider how you write your comments and suggestions. While the tone of the conversation definitely depends on the person reading the comment, consider how you write the comments as well. 

You might know more about the topic and add some suggestions to improve the code. There could be some silly mistakes that were missed but should still be pointed out. That's all part of the review process. 

PR reviews are not only to point issues and mistakes, try to add some encouraging comments as well if someone has done something exceptionally well. A small encouragement and a nice word go a long way!

## Put asside time to review assigned PRs

This is a good practice to consider. No one likes to wait long time for their PRs to be reviewed just because the reviewers are not paying attention. 

I don't think anyone is fond of doing PR reviews. They are distracting and require the reviewer to completely switch their focus from the work they are doing. But, they are a part of your daily work.

Set aside some time early in the morning before you start your work. Or right before the end of work before you close your laptop for the day. 

## Use a menu app to keep track of all PRs

This one is a time saver! I've learned this from a colleague at work and I'll never go back.

There's a macOS menu bar app called [SwiftBar](https://github.com/swiftbar/SwiftBar) that can run custom shell scripts and add them to your menu. It has a plugin repository that you can search or write your own scripts. There are probably some other apps out there as well, but this one works like a charm.

![SwiftBar menu app showing 1 PR in the menu and detailed information about it](https://www.danijelavrzan.com/images/posts/2023/11/review-pull-requests-01.png "SwiftBar menu app showing 1 PR in the menu and detailed information about it")

Get the GitHub repository plugin and adjust it to work for your repositories. When someone assigns a PR to you on the repositories you're watching, it will let you know in the menu bar and show the number of PRs. Once you review a PR, the number will go down. It's really handy!

## Reviewing the PR

Before you start reviewing the PR, make sure the PR is ready to be reviewed. While it's on the PR author to make sure that's the case, sometimes you'll get assigned to a PR that's not quite yet ready to be reviewed. Ask for any missing information and come back to it later.

Now's the time to start the review process.

### Grammar mistakes

Grammar mistakes can happen to anyone.

It's okay to comment on grammar mistakes you see in the code. Code should be easily readable and sometimes a missing letter can completely change the meaning of the word. If you spot them, call them out.

### Naming

Naming objects and variables in the code is hard. Really.

When you're writing code, a name you give to a variable might make sense to you in that specific moment. But the meaning can be completely lost on another person. 

If you're reading someone else's code and the name doesn't make sense to you and you can't infer the meaning from the context, let the author know. It's likely someone else will have the same issue as you. Suggest a different name if you have any other ideas or talk with the author and come to an agreement. 

### Understanding the code

Naming conventions and grammar mistakes are a few things you can start with when doing a code review, but you'll also have to understand the logic.

This is probably the hardest part of the review. The more experienced you are, the easier it will be. If the PR author created a good PR and gave enough information with screenshots or videos, your job will be much easier. A good PR makes a world of difference. 

In any way, you need to understand what you're reviewing. At least, to the best of your knowledge. 

Ask for help. Message the PR author directly and ask them to walk you through the code. It's fast and it will give you the context you could be missing. There's no shame in asking for help.

This is especially useful for large PRs.

### Code improvement suggestions

If you can spot a line of code that can be improved, suggest it to the author and explain why you think it should be changed. Maybe you've learned something new recently and can suggest a good improvement to the code. Or maybe the new language version came out recently and changed how the code is written.

Whatever the reason, if you can spot any code improvements, suggest them to the author and always try to add a reason behind it. 

Don't request a code change just because you prefer to do it some other way yourself. If it doesn't add real value, don't be pushy about it.

### App UI vs design

If the PR you're reviewing has a UI component to it, check if the app's UI looks like the design. There should be a link to the design in the PR or the work ticket itself. If it's not, ask the code author to provide the link. 

If you notice something wasn't done correctly, mention it to the author so they know to correct it.

### Tests and code coverage

It's likely you'll have a test coverage report on the PR itself, once the CI has finished running. However, check if tests have been added or updated in the PR. Sometimes, people forget to add tests. Especially if CI passes and code coverage for the PR is satisfied. 

If you notice tests are missing or a specific edge case hasn't been tested, mention it in the review.

## Final Thoughts

Reviewing code is hard. But it's a great learning opportunity. It's also a good place to catch any issues in the code and reduce potential bugs in the code. We all make mistakes.

PRs are part of our everyday work, whether that's creating them or reviewing them. Just as you would care about writing your code well, give the same effort to reviewing someone else's code. 

It's okay to review and approve the PR with no comments if you haven't noticed anything that can be changed or improved. Give a thumbs up and say "good work".

***

Please feel free to reach out on [X (Twitter)](https://twitter.com/dvrzan) or [Mastodon](https://iosdev.space/@dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
