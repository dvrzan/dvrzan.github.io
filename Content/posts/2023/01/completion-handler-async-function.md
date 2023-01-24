---
date: 2023-01-24 08:45
description: When the new Swift concurrency model was announced at WWDC 2021 we all wanted to jump on that wagon. However, rewriting your entire codebase might not be the best solution. Instead, you have the option to slowly start adapting the new model by bridging the old code with the new.
image: https://www.danijelavrzan.com/images/posts/2023/01/completion-handler-async-function.png
tags: swift, concurrency
---

# How to use async/await with completion handlers

We've all been there. WWDC announces a shiny new API that would make all your problems go away, but your app supports an older version of iOS and you have to wait for a few years to implement it. *(Sigh)*

Swift's new concurrency model was announced at WWDC 2021 along with iOS 15. A few months later, starting with Xcode 13.2, it became backwards compatible up to iOS 13. This meant you could use the new concurrency model even if you had to support older versions of operating system.

However, as with anything else, it wasn't that simple. 

## Completion handlers

It's likely your codebase has at least one completion handler. Rewriting entire codebase or even just your networking layer to use async/await might not be a trivial task. 

Consider the following code:

```swift
func getJokes(completion: @escaping ([Joke]) -> Void) {
  let url = URL(string: "https://official-joke-api.appspot.com/jokes/ten")!

  URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data else {
      completion([])
      return
    }
    if let jokes = try? JSONDecoder().decode([Joke].self, from: data) {
      completion(jokes)
      return
    }
  }
  .resume()
}
```

It's fetching 10 jokes from a Joke API using the `dataTask(with:)`, decoding them into an array, and returning with a completion handler. Your standard networking code.

Completion handlers are not `async`, at least not in the new concurrency model way. You can't use them in the async/await context as-is. But there's a way to integrate them into the new model using **continuations**.

## Continuations

Continuations are structs with a specific generic type that allow us to bridge completion handlers with the new async/await code. This allows us to continue using our old code without having to completely rewrite it and still benefit from the new concurrency model. This way you can slowly adapt your codebase to use async/await.

To use continuation with the above function you'll write a new async function `getJokes()` that calls the old function and returns a value:

```swift
func getJokes() async -> [Joke] {
  await withCheckedContinuation { continuation in
    getJokes { jokes in
      continuation.resume(returning: jokes)
    }
  }
}
```

Continuation is created by calling the `withCheckedContinuation()` function which suspends the current task and then passes the continuation to the closure as a captured value. Continuation is resumed by calling the `resume(returning:)` method.

> It's very important to keep in mind you must call a resume method **exactly once on every execution path**. If you call it more than once, your program will crash. If you forget to call it at all, you'll get a big warning in the console because you're leaving your task unsuspended. This means your resources are being retained indefinitely and could cause data leaks.

Finally, you can now call the new function with `await`:

```swift
let jokes = await getJokes()
```

With continuations, you're not completely rewriting your existing code, but rather incorporating the new async/await model to get all the benefits of it. This way, you can slowly start moving towards the new concurrency model.

## Checked/unchecked and throwing continuations

There are a few different ways to implement continuations in your code:

- **withCheckedContinuation()**, which we implemented above
- **withCheckedThrowingContinuation()**
- **withUnsafeContinuation()**
- **withUnsafeThrowingContinuation()**


We've already mentioned you must resume your continuation **exactly once** on every execution path. `CheckedContinuation` performs runtime checks for you and makes sure there are no missing, or multiple, resume operations. It will log a message in the console if these are violated.

`UnsafeContinuation`, on the other hand, doesn't enforce these rules during runtime so make sure you're using it only if you have to and if it causes a runtime performance problem. 

`CheckedThrowingContinuation` and `UnsafeThrowingContinuation` let us create continuations that can throw errors. 

There are also a few different ways to resume the task:

- **resume(returning:)** resumes the tasks normally from suspension
- **resume(throwing:)** resumes the task by throwing an error
- **resume(with:)** resumes the task either normally or throws an error based on the given `Result` value

All of these are used depending on the type of continuation you're using and the return value.

## Final Thoughts

Implementing continuations means we don't have to wait years to be able to incorporate the new concurrency model in our code. We can bridge our existing code and get all the benefits of the new async/await model. This means you can also start adopting it in your codebase without having to completely rewrite the old code.

[Chris Lattner's](https://twitter.com/clattner_llvm) [Swift Concurrency Manifest](https://gist.github.com/lattner/31ed37682ef1576b16bca1432ea9f782#file-taskconcurrencymanifesto-md) is an interesting read if you'd like to learn more about the design and the background story on Swift's new concurrency model.

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
