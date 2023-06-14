---
date: 2023-06-14 08:45
description: Localizing your app is a big part of making it more inclusive and available to people in other languages. Apple has made it easier for developers to localize our apps. Starting with Xcode 15 and String Catalogs. 
image: /images/posts/2023/06/string-catalog.png
tags: xcode, swift
---

# Localize your app with String Catalog

Localizing your app is a big part of making it more inclusive and available to people in other languages.

Previously, if you wanted to localize your app, you had to maintain `strings` and `stringsdict` files yourself. It was a lot of manual work that often resulted in missing localized content. 

Apple has made it easier for developers to localize our apps, starting with Xcode 15 and **String Catalogs**. 

> You can start using String Catalog with Xcode 15 and it's back deployable to any OS, no minimum version required!

## String Catalog

String Catalog makes it easy to manage all your strings in one place and make sure your content is fully localized before the app reaches your users.

We'll localize this small app for ordering books:

![iPhone showing Buy Books screen in an app](/images/posts/2023/06/string-catalog-01.png "iPhone showing Buy Books screen in an app")

Localizing your app is as easy as creating a new file under **File** -> **New** -> **File...** and selecting **String Catalog** under **Resources**. Name your new file and once you click **Create**, that's it!

![Xcode screen with an Empty String Catalog warning](/images/posts/2023/06/string-catalog-02.png "Xcode screen with an Empty String Catalog warning")

Almost. 

String Catalog generates and updates your localizable strings on build time. If you're creating a new catalog, you need to build your project to populate the strings.

Build the project in Xcode and you'll see all your strings automatically added to the table.

![String Catalog in Xcode with populated strings](/images/posts/2023/06/string-catalog-03.png "String Catalog in Xcode with populated strings")

## Build Settings

String Catalog uses a technology in the Swift compiler to extract localizable Swift strings. For this reason, make sure you've enabled the build setting **Use Compiler to Extract Swift Strings** under **Localization**:

![Use Compiler to Extract Swift Strings build setting](/images/posts/2023/06/string-catalog-04.png "Use Compiler to Extract Swift Strings build setting")

## Localizable String

Localizable strings are found in source code, interface builder files and even Info plists.

Take a look at this `String`:

```swift
String(
	localized: "buy.books.title",
	defaultValue: "Buy Books",
	table: "Purchases",
	comment: "Screen title for buying books"
)
```

Localizable strings have four components. The first one is the `Key`, a unique identifier for your string. It can be equal to the string itself or any other format you like. For example, the key for the title string could be "Buy Books" or "buy.books.title". 

If you have a string with a key as "buy.books.title", you'd want to give it a `Value` of "Buy Books". Value is optional and if not provided, the default value is your key. You'll see shortly why you'd want to have your key in this format for some of your strings.

Next, `Comment` provides a way to give your translators context around a specific string to provide a proper translation. It's not a required field, but it's recommended.

And finally, you can specify the `Table` where you want your string stored. You can have multiple tables, depending on your use case. By default, strings from your code get generated in "Localizable" catalog.

> String Catalog contains an entire string table in a single `.xcstrings` file. Your project can have more tables if needed.

Every time you create a string literal in your code, it automatically becomes localizable. Whether you specify it inside a `View` or create a `String` variable:

```swift
struct ContentView: View {
    var cancelOrderNew = String(
        localized: "Cancel.order.new",
        defaultValue: "Cancel",
        comment: "Cancel button on the new order screen"
    )
    
    var body: some View {
        HStack(spacing: 30) {
            // `Cancel` button
            Button {
                // action
            } label: {
                Text(cancelOrderNew)
            }
            // `Buy` button
            Button("Buy") {
                // action
            }
        }
    }
}
```

### Non-localizable strings

If you want to mark your string as non-localizable and exclude it from localization, initialize it with `init(verbatim:)` initializer instead.

```
Text(verbatim: "AppName")
```

This comes useful for strings like your app name that don't need to localization and will always display the same in all languages. 

If string was already added to the String Catalog, it will be automatically removed on build time.

## Adding other languages

To localize your app in another language, click the **+** button at the bottom left of the table and choose a new language. It will add the new language and populate all the strings for you. 

![String Catalog in Xcode with populated strings in Croatian language](/images/posts/2023/06/string-catalog-05.png "String Catalog in Xcode with populated strings in Croatian language")

It also shows you the percentage of your localized strings and updates the status to `NEW`, until all strings have been reviewed.

There are a few different **STATE** status badges available:
- `STALE` - string is not found in the code anymore. 
- `NEW` - a new string you haven't yet translated. 
- `NEEDS REVIEW` - string has changed in the code and you might want to take a look to make sure it's still valid.
- `TRANSLATED` - string has been translated in the selected language and no action is needed.

## Different localization keys for the same string

Some languages vary the localized text based on the given context. 

It's likely you'll have to repeat the same string in your app on multiple screens. One of the common examples is a **Cancel** button. In English, the Cancel button is always the same string, but in some other languages, like Croatian, it can have different strings based on the surrounding context. 

This is where you'd want to define a different key for the string with a default value.

```swift
var cancelOrderInProgress = String(
    localized: "Cancel.order.in.progress",
    defaultValue: "Cancel",
    comment: "Cancel button on the orders in progress screen"
)
var cancelOrderNew = String(
    localized: "Cancel.order.new",
    defaultValue: "Cancel",
    comment: "Cancel button on the new order screen"
)
```

> Keys have to be unique inside a table.

Make sure to add a comment here so your translator knows the surrounding context. It's a good idea to always add comments, not only for your translators, but for yourself as well.

## Word variations

String Catalog comes with a built-in feature for localizing different word variations.

### Vary by Device

Some strings have different variations depending on the device your app is being used. 

```swift
Link(
    destination: URL(string: "https://www.url.com")!,
    label: {
        Text("Tap to learn more!")
    }
)
```

"Tap to learn more!" works well for an iPhone or an Apple Watch, but users can't tap on their Macs. In the String Catalog, you can **right-click** on a table row and add a **Vary by Device**. This will add a new entry where you can specify a different string for a Mac, or any other Apple device on the list.

![String Catalog in Xcode with vary by device option](/images/posts/2023/06/string-catalog-06.png "String Catalog in Xcode with vary by device option")

### Vary by Plural

It's never been easier to localize plural words too. **Right-click** the table row and add **Vary by Plural**. 

![String Catalog in Xcode with vary by plural option](/images/posts/2023/06/string-catalog-07.png "String Catalog in Xcode vary by plural option")

In English language, every plural word is the same - "books". However, Croatian is not that simple. There are different variants in the plural. For a few books, or 2, 3 and 4, the plural word is different. For 5 - 10 books the word is the same as for a single book. 

It's confusing, let me show you.

![String Catalog in Xcode with vary by plural option](/images/posts/2023/06/string-catalog-08.png "String Catalog in Xcode vary by plural option")

Apple made sure to add all the different variants for different languages. It's awesome how easy it is to localize your app now!

## Custom Views

If you're creating custom views in your app and passing strings to other views, your strings need to be of type `LocalizedStringResource`, instead of `String`, if you want them localized.

```swift
struct CustomView: View {
    var title: LocalizedStringResource
    var subtitle: LocalizedStringResource
    
    var body: some View {
        VStack {
            Text(title)
            Text(subtitle)
        }
    }
}
```

## Migrating to String Catalog

String Catalog can coexist with your current localizable strings. Once you're ready to migrate to the new format, **right-click** the `.strings` file and choose **Migrate to String Catalog**.

You'll see a new window with all your `.strings` and `.stringsdict` files where you can select ones that you want to migrate. Click **Migrate** and you're all done!

## Final Thoughts

You still need translators to translate all your strings, but String Catalog makes it easier than ever to localize your apps. Your code is the source of truth for all your strings and you don't have to manage them manually anymore.

If you want to learn more, watch the [Discover String Catalogs](https://developer.apple.com/videos/play/wwdc2023/10155/) session from WWDC23. 

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!