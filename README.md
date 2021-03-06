# Eventful-Swift
Simple, lightweight, and useful event library for Swift.

## Overview
Eventful-Swift is a Swift library for lightweight event dispatching & handling. By conforming to the `EventDispatcher` protocol, a class or struct can define various events (via `Event<T>` or `EventRef<T>`) that can be listened for and reacted upon. This library is a _work in progress_.

## Installation
### CocoaPods
Eventful-Swift is integrated with CocoaPods!

1. Add the following to your `Podfile`:
```
use_frameworks!
pod 'Eventful-Swift'
```
2. In your project directory, run `pod install`
3. Import the `EventfulSwift` module wherever you need it
4. Profit

### Manually
You can also manually add the source files to your project.

1. Clone this git repo
2. Add all the Swift files in the `Eventful-Swift/` subdirectory to your project
3. Profit

## Events
### Dispatching Events
Using `Event<T>` or `EventRef<T>`, you can easily add **action** → **reaction** based event handling to your existing code.

```swift
class Person: EventDispatcher {

    var name: String
    var age: Int
    var event_died = EventRef<Bool>()

    func removeEventListeners() {
        self.event_died.removeListeners()
    }

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    deinit {
        self.event_died.dispatch(true)
    }

}
```
In the above example, the `Person` class conforms to the `EventDispatcher` protocol, and defines one event: `event_died` which gets posted when the `Person` instance is about to be deallocated. The event is of the `EventRef<T>` type, where `T` is a generic type representing the value that will be passed back to the event's listeners.

You can either make your events be of the `Event<T>` type - which is a struct. Or the `EventRef<T>` type - which is a class. Just depends on your situation. Under the hood, the `EventRef<T>` class holds a private `Event<T>` struct, which it forwards all calls to.

You dispatch your event by simply calling it's `dispatch(value: T)` function, passing in the value to return to the event's listeners.

### Registering an Event Listener
Listening and reacting to events is just as easy as dispatching them. You simply register as a listener and assign a **reaction** closure.

```swift
var person: Person? = Person(name: "Bob", age: 23)
person?.event_died.addListener { (value: Bool) in
    print("Bob died 😭")
}

print("\(person?.name) was born 😄")
print("\(person?.name) is living his life...")

person = nil
```
The console output will read:

```
Bob was born 😄
Bob is living his life...
Bob died 😭
```

In the above example, we added a listener to our person's `died` event. When the event was dispatched we simply printed `Bob died 😭` to the console.

### Removing Event Listeners
Just like adding event listeners, we can also remove them. The `addListener` function is actually defined as: `addListener(handler: (T) -> ()) -> EventToken<T>`. It returns an `EventToken<T>` which can later be used to remove a listener from an event. The above example can be modified to show this:

```swift
var person: Person? = Person(name: "Bob", age: 23)
let eventToken = person?.event_died.addListener { (value: Bool) in
    print("Bob died 😭")
}

print("\(person?.name) was born 😄")
print("\(person?.name) is living his life...")

person = nil

person?.event_died.removeListener(token: eventToken)
```

Alternatively, you can remove all listeners from a specific event by calling an event's `removeListeners()` function. The `EventDispatcher` protocol also requires that a `removeEventListeners()` function be implemented on any event-generating entity. Because of this, you can remove all listeners for all events by calling `removeEventListeners()` - assuming the event-generating entity has correctly implemented the function.

```swift
// Removes all listeners for a specific event
person?.event_died.removeListeners()

// Removes all listeners for every event on an entity
person?.removeEventListeners()
```

## Eventful Values
The `EventfulValue<T>` type is a custom `EventDispatcher` that dispatches events when it's underlying value is about to change, and after it's value has successfully been changed. Simply put, it's a tiny value-wrapper that mimics **KVO** value changes. `EventfulValue<T>` defines two events:

- `event_willChangeValue`
- `event_didChangeValue`

```swift
var greeting = EventfulValue("Hello")
greeting.event_didChangeValue.addListener { (info: EventfulValueInfo)
    print("greeting: didChangeValue - was: \"\(info.oldValue)\", now: \"\(info.newValue)\"")
}

greeting.set("Bonjour")
```

This will set the value of `greeting` to `"Bonjour"`, and fire off our variable's `didChangeValue` event. Notice closure provides a variable of the `EventfulValueInfo<T>` type. This is a struct that contains both the old and new values of the changed variable.

### Working with EventfulValue
Because the `EventfulValue<T>` type "wraps" the actual value for event handling, simple set/get statements will not work. Instead, you must directly access it's underlying value via the `value` member. You can also use the `get() -> T` or `set(value: T)` functions.

```swift
var x = EventfulValue(7)

// Will not work:
x = 13

// Will work:
x.value = 13
x.set(23)

let xValue = x.get()
print("value of x is \(xValue)")
```

#### Shorthand Syntax
Having to manually type out `EventfulValue`, and access the underlying `value` member can get tedious. Luckily, there is also a shorthand syntax for initializing, modifying, and retrieving this value.

```swift
// These are all valid ways to initialize an EventfulValue
var x = EventfulValue(10)
var y = ~("Hello, world!")
var z = ~[1, 2, 3]

// EventfulValue's can be modified by using the '~>>' operator
x ~>> 13
y ~>> "Hola!"
z ~>> [4, 5, 6]

// An EventfulValue's value member can be accessed via a postfix '~'
let xValue = x~
let yValue = y~
print("value of z is \(z~)")
```

You can initialize an `EventfulValue` by prefixing a value with an tilde (`~`). You can optionally also surround the value with parenthesis. The `~>>` assignment operator can be used to directly assign a value to an `EventfulValue`'s underlying `value` member. Lastly, you can directly access the underlying `value` member with a postfix tilde (`~`).

## Upcoming Features
- `EventfulValue` subscripting. This will make working with tuples, arrays, and dictionaries easier.
- More built-in `EventDispatcher` classes.
