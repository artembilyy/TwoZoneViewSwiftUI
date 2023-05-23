# TwoZoneViewSwiftUI

# Two-Zone View - SwiftUI

<img width="476" alt="Screenshot 2023-05-23 at 15 28 44" src="https://github.com/artembilyy/TwoZoneViewSwiftUI/assets/110157916/b92192a2-3515-4602-ba5c-d70e16dd474a">

This is a test project for implementing a custom SwiftUI view with two zones: the yellow zone and the blue zone. The yellow zone supports multitouch with multiple fingers, while the blue zone only handles single-finger touch events. The blue zone can also be hidden, in which case the yellow zone occupies the entire view. The view is capable of resizing and repositioning itself, and its four corners are always rounded.

## Task

The task is to create a SwiftUI view that meets the following requirements:

1. Create a view with the specified design using SwiftUI.
2. Add two text fields for the dimensions of the view (height and width). The allowed range is 0 <= value <= Int.max.
3. Add two fields for the position of the view (x, y). The allowed range is Int.min <= value <= Int.max.
4. Add a button that, when pressed, changes the position and dimensions of the view. Perform validation on the input values and display errors to the user if necessary.
5. Add a button/toggle/other control to hide the blue zone, allowing the view to be displayed with or without it.

Implement the `TwoZoneHandler` interface and output the data from its functions to the output. 

```swift
protocol TwoZoneHandler {
    func onBlueZoneEvent(isPressed: Bool)
    func onYellowZoneEvent(
        idx: Int, // finger index
        x: Double, // coordinate in percentage of width (0…100)
        y: Double // coordinate in percentage of height (0…100)
    )
}
```
## Requirements

The following requirements should be met:

1. When touching the yellow zone, call onYellowZoneEvent() and pass the finger index and the position as a percentage of width and height of the zone.
2. When a finger is lifted or moved, no output should be generated.
3. The blue zone should call onBlueZoneEvent() with true when a finger touches it and false when the finger is lifted. The blue zone should only handle one finger and ignore any additional fingers.
4. The blue zone should occupy 30% of the total height of the view, while the yellow zone occupies the remaining space.

Please note:

- Multitouch in the yellow zone can be handled using UIKit by leveraging UIViewRepresentable.
- Both zones should be able to handle touch events simultaneously.
- The output format for the data can be customized as long as it is clear and understandable.
- Separate the view logic from the view itself using an appropriate architectural pattern such as MVVM, MVP, MVC, etc.
- The finger index refers to the order in which the fingers are placed on the screen. For example, if there are currently two fingers on the screen, the indices would be [0, 1]. If the finger with index 0 is lifted, the index of the remaining finger would still be 1. If another finger is then placed on the screen, the indices would be [0, 1] again.
- Choose the corner radius, initial position, and size of the view according to your preference.
- Decide how to display or communicate validation errors for dimensions and position (e.g., text, alert, etc.).

# This project is intended as a test task to assess your SwiftUI skills and understanding of touch event handling.
