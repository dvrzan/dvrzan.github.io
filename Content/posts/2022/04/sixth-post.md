---
date: 2022-04-25 08:45
description: 
image: /images/posts/2022/04/name.jpg
published: true
tags: swift, unit test
---

# Testing how an article looks like when it's published

func - `func` Lorem ipsum dolor sit amet, `consectetur` adipiscing elit. Nulla ornare nulla risus, eget viverra odio posuere et. Pellentesque et justo ac massa facilisis ornare dignissim in mauris. In nulla velit, pulvinar vitae nibh vel, aliquam mollis tellus. 

> Block quoted text line 1 df gdf gdf gdf gdf gdfg

Interdum et `malesuada` fames ac `ante` ipsum primis in `faucibus`. Sed auctor, mauris nec lacinia finibus, urna velit blandit dui, ut commodo leo ligula quis tellus. Vivamus ornare augue quis lacus accumsan, sit amet mollis arcu tempor. 

Mauris `mollis` est sed lectus imperdiet, sit amet tincidunt dui finibus. Mauris aliquet lacinia neque in eleifend. Ut venenatis id orci in lacinia. 

## Cras tristique libero a nulla

Sed nunc elit, aliquet eget odio sed, fringilla iaculis libero. Aliquam cursus, est ut vulputate dignissim, erat lacus faucibus neque, vitae bibendum augue neque sed nisl. Donec `maximus tellus` in posuere faucibus. Etiam sodales hendrerit placerat. Integer ultrices mollis vulputate. 

Mauris a nulla a dolor feugiat `sollicitudin`. Phasellus nulla diam, venenatis ac sapien id, sodales vehicula lectus.

```swift
// MARK: - Test doubles
class CreateIceCreamInteractorSpy: CreateIceCreamBusinessLogic {
  var loadIceCreamCalled = false

  func loadIceCream(request: CreateIceCream.LoadIceCream.Request) {
    loadIceCreamCalled = true
  }
}
```

Instead use this code to use the locally available version:

```swift
override func setUpWithError() throws {
  try super.setUpWithError()
  sut = CreateIceCreamView()
  interactorSpy = CreateIceCreamInteractorSpy()
}
```

## Phasellus ullamcorper hendrerit eros

Nam erat dui, auctor ut porttitor id, ultrices vitae nisl. Donec pulvinar sagittis sem, a aliquam nunc fermentum ac. Nulla facilisi. Nunc tincidunt erat eu enim dictum, tincidunt dignissim neque pellentesque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. 

> Block quoted text line 1
>
> Block quoted text line 2

Duis id lorem ligula. In bibendum lacus ut sem euismod laoreet. Donec elit lectus, volutpat a ultricies sit amet, efficitur sed mi. In aliquet felis nec diam aliquet feugiat. Aenean neque dui, pharetra nec mattis non, elementum sed diam. Pellentesque nisl ipsum, auctor vitae imperdiet ut, malesuada id leo. 

Ut sagittis pulvinar felis, ut bibendum risus viverra vulputate. Nunc mollis augue vel ante tristique volutpat. Donec sit amet lacinia nisl. Duis in quam elit.

Nam erat dui, auctor ut porttitor id, ultrices vitae nisl. Donec pulvinar sagittis sem, a aliquam nunc fermentum ac. Nulla facilisi. Nunc tincidunt erat eu enim dictum, tincidunt dignissim neque pellentesque:

```swift
enum CreateIceCream {
  enum LoadIceCream {
    struct Request {}

    struct Response {
      var iceCreamData: IceCream
    }

    struct ViewModel {
      var cones: [String]
      var flavors: [String]
      var toppings: [String]
    }
  }
}
```

Aenean vel est eget tellus finibus posuere vel ac eros. Donec `finibus` porta ipsum at `malesuada`. Praesent vitae mauris sit amet sapien scelerisque porttitor. Maecenas maximus vel tellus eu porttitor. Mauris at auctor leo. 

Cras rutrum mi lacus, sed feugiat dui `congue non`. Phasellus ullamcorper hendrerit eros. Cras tristique libero a nulla euismod tempor. Quisque rhoncus neque ante, eget consectetur diam `facilisis` nec. Nam sodales vel purus ut consectetur. Morbi ut libero non tellus hendrerit sagittis dapibus eu sapien.

```swift
Picker("Choose your flavor", selection: $selectedFlavor) {
  ForEach(iceCream.displayedFlavors, id: \.self) {
    Text($0)
  }
}
.disabled(selectedCone.isEmpty)
```


## Aenean vel est eget tellus

Phasellus `ullamcorper` hendrerit eros. Cras tristique libero a nulla euismod tempor. Quisque rhoncus neque ante, eget consectetur diam facilisis nec. Nam sodales vel purus ut `consectetur`. 

- test1
- test2
- test3
- what

Morbi ut libero non tellus hendrerit sagittis dapibus eu sapien.

