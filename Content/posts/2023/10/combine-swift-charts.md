---
date: 2023-10-18 08:45
description: SwiftCharts framework makes it easy to add charts to your app and display the data to your users in a visually pleasing way. In this article, we'll design a custom chart to display weight tracking data over a period of one week. We'll utilize line chart and area chart to make our graph look more stylish. 
image: /images/posts/2023/10/combine-swift-charts.png
tags: swiftUI, design
---

# Combine charts to create stunning designs with Swift Charts

[Swift Charts](https://developer.apple.com/documentation/charts)  is a data visualization framework that can be used with SwiftUI to create powerful customizable charts with minimal code. Use it to present your app's data in a visually pleasing way. 

> Swift Charts were announced at **WWDC22** and are available to use with **iOS 16.0+**.

There are many different chart types available; including line charts, bar charts, area charts, and scatter plot charts. They are easy to use and offer a wide range of customization options. You can apply different modifiers to override default behavior and add animations.

Localization and accessibility features are supported as well.

In this article, we'll design a custom chart to display weight tracking data over a period of one week. We'll utilize **Line Chart** and **Area Chart** to make our graph look more stylish. 

Final chart will look like this:

![iPhone showing a screen with a custom chart displaying weight tracking data over a period of a week](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-01.png "iPhone showing a screen with a custom chart displaying weight tracking data over a period of a week")

## Data Model

To create the chart, we need data. We'll use a model that stores the weight and the date the weight was measured. Then we'll add some test data for a period of one week.

```swift
// Data Model
struct TestWeight: Identifiable {
    var id = UUID()
    var weight: Double
    var date: Date

    init(id: UUID = UUID(), weight: Double, day: Int) {
        self.id = id
        self.weight = weight
        let calendar = Calendar.current
        self.date = calendar.date(from: DateComponents(year: 2023, month: 10, day: day))!
    }
}

// Test data
var weight: [TestWeight] = [
    TestWeight(weight: 69.4, day: 2),
    TestWeight(weight: 69.2, day: 3),
    TestWeight(weight: 70.0, day: 4),
    TestWeight(weight: 69.7, day: 5),
    TestWeight(weight: 69.0, day: 6),
    TestWeight(weight: 68.8, day: 7),
    TestWeight(weight: 68.0, day: 8)
]
```

## Implement Line Chart

Before creating a chart, you need to `import Charts` at the top of the file.

We'll start with the basic line chart called `LineMark`, the one you get out-of-the-box.

```swift
Chart {
    ForEach(weight) { data in
        LineMark(
            x: .value("Day", data.date, unit: .day),
            y: .value("Weight", data.weight)
        )
        .foregroundStyle(Color.pink)
    }
}
.frame(height: 150)
```

`LineMark` displays the data in a sequence of connected line segments. It has an **x** and **y** positions. We iterate over the `weight` data and display the `date` on the **x-axis** and `weight` on the **y-axis**.

You can use the `.foregroundStyle()` modifier to add a color to your chart. I'm using the system `.pink`.

![Line Chart showing weight data on the y-axis and dates on the x-axis](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-02.png "Line Chart showing weight data on the y-axis and dates on the x-axis")

The chart looks great considering we just used the basic line chart with no customization. One of the biggest issues at the moment, is the chart looks almost like a straight line. 

That's because our weight data doesn't change in value drastically day by day. That's a good thing as far as the data is concerned! However, it doesn't look very good and you can't really see the change. 

## Override default chart elements

We'll customize the chart to scale better for our specific use case. 

There are many different customization options available to create amazing charts. It depends what data you're displaying and how you want to design the chart. We'll go through a few different options.

### Add a symbol

We'll add a circle symbol to mark the days the weight change happened so we can see it more clearly. Add the `.symbol()` modifier to the `LineMark` with a circle shape:

```swift
.symbol {
    Circle()
        .fill(Color.pink)
        .frame(width: 8)
}
```

Your chart will now look like this:

![Line Chart showing weight data on the y-axis and dates on the x-axis with a symbol](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-03.png "Line Chart showing weight data on the y-axis and dates on the x-axis with a symbol")

Much better!

### Customize the x-axis

The bottom of the chart, or x-axis, shows the days in a short date format in incremental values of two, so every other day. I want to show my data for every day of the week. We'll customize the x-axis to display the data how we want to.

For that, we have the `chartXAxis(content:)` modifier. 

Let's use it to modify our x-axis. Add the modifier to the `Chart()` below the frame:

```swift
.chartXAxis {
    AxisMarks(values: .stride(by: .day)) { _ in
        AxisTick()
        AxisGridLine()
        AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
    }
}
```

`AxisMarks` defines group of visual marks that a chart draws to indicate the composition of a chart’s axes. It allows us to define properties like the grid line and the value label. 

We changed the label format to show the days of the week in `.abbreviated` format.

![Line Chart showing weight data on the y-axis and days of the week on the x-axis](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-04.png "Line Chart showing weight data on the y-axis and days of the week on the x-axis")

### Customize the y-axis scale

The y-axis scale presents a *problem* in our case. It's very unlikely someone will have a weight of 0. And even although the weight changes every day, it's not going to change drastically.

We'll add another modifier to the chart called `.chartYScale` and add a custom scale that makes more sense for our data.

```swift
.chartYScale(domain: 62...70)
```

I'm using hard-coded values from **62 - 70**. If you were implementing this yourself, you'd want to make these values dynamic. 

![Line Chart showing weight data on the y-axis with custom scale and days of the week on the x-axis](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-05.png "Line Chart showing weight data on the y-axis with custom scale and days of the week on the x-axis")

The bottom value of **62** correlates to the **weight goal** the user has set for themselves, which we'll set with the value of **63**. The bottom value is the **goal weight - 1**. This is intentional. 

We'll add a rule mark to display the goal weight for the user and move that line by 1 on the chart so there's some space between the goal line and the x-axis. 

## Add a Rule Mark

Next, we'll add a rule mark or the weight goal line. We want the user is track their weight and see where they stand compared to their weight goal. We'll use a weight goal of **63**.

```swift
// Line Chart

// Rule mark for the goal weight
RuleMark(y: .value("Goal Weight", 63))
    .foregroundStyle(Color.secondary)
    .lineStyle(StrokeStyle(lineWidth: 0.8, dash: [10]))
    .annotation(alignment: .topTrailing) {
        Text("Your Goal:  63 kg")
            .font(.subheadline).bold()
            .padding(.trailing, 32)
            .foregroundStyle(Color.secondary)
    }
```

Rule mark adds a line graph to your chart and it can be positioned on the x or y axis. We added a rule mark on the x axis with the value of **63**. I want to add some style to it so I added a custom dashed line style and annotated the graph to display the goal weight data on the graph itself. 

![Line Chart showing goal weight as a rule mark](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-06.png "Line Chart showing goal weight as a rule mark")

Now that's starting to look quite nice!

## Add an Area Chart

The graph looks nice, but I want to make it even better. It looks empty so I want to color the area below the graph to give it some *life*.

We'll add an area chart and apply some custom styling.

Add an `AreaMark` to the chart below the `RuleMark`:

```swift
// Line Chart

// Rule mark for the goal weight

// Area Chart
ForEach(weight) { data in
    AreaMark(
        x: .value("Day", data.date, unit: .day),
        yStart: .value("WeightLow", 63),
        yEnd: .value("WeightLow",  data.weight)
    )
  .foregroundStyle(Color.pink)
}
```

`AreaMark` can be initialized with the same **x** and **y axis** properties. In this case, we used a different initializer with the **x**, **yStart**, and **yEnd** properties. We need this initializer to apply our custom color formatting.

The `x` value is the horizontal position on the chart, or where our area chart starts and ends on the x-axis. 

`yStart` value is the bottom vertical constraint for the area chart on the y-axis. It's set to the value of the rule mark, or the goal weight. This is where we want the color to start. 

`yEnd` is the top vertical constraint for the area chart on the y-axis. The values correspond to the same values as the line chart so the charts blend in without overlapping. This is where our color will end.

It doesn't look good with the solid color, so we need to create a new gradient color for it. I've played around with the opacity values to make it look nice for this one.

```swift
var gradientColor: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors: [
                Color.pink.opacity(0.8),
                Color.pink.opacity(0.01),
            ]
        ),
        startPoint: .top,
        endPoint: .bottom
    )
}
```

Now change the foreground style from `Color.pink` to `gradientColor`.  

And that's it! We have our custom chart.

![Custom line chart with gradient colored area below the chart](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-07.png "Custom line chart with gradient colored area below the chart")

## Add some information about the chart

For the final design, we'll add our chart to a `VStack` and add some information about the chart.

```swift
VStack(alignment: .leading) {
    VStack(alignment: .leading) {
        Text("Weight")
            .font(.title3).bold()
        Text("Last 7 days")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.bottom)
    }
    
    Chart()
}
```

Now it looks much better!

![Custom line chart with gradient colored area below the chart and informational text above the chart](https://www.danijelavrzan.com/images/posts/2023/10/combine-swift-charts-08.png "Custom line chart with gradient colored area below the chart and informational text above the chart")

## Final Thoughts

SwiftCharts really makes it easy to add charts to your app and display the data to your users in a visually pleasing way. Much better than a list of raw data values.

Default charts are well designed and can be used without much customization. But if you want to customize any part of the chart, there are many different modifiers available. 

I've had a lot of fun playing with this chart and I hope you will too. If you've played around and created some custom charts yourself, let me know! I'm interested to see your amazing creations.

***

Please feel free to reach out on [Twitter](https://twitter.com/dvrzan) if you have any questions, comments, or feedback.

Thank you for reading and happy coding!
