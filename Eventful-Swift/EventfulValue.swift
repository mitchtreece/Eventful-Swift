//
//  EventfulValue.swift
//  Eventful-Swift
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

infix operator ~>> { associativity left precedence 80 }
public func ~>> <T>(inout eventful: EventfulValue<T>, value: T) {
    eventful.set(value)
}

prefix operator ~ {}
public prefix func ~ <T>(value: T) -> EventfulValue<T> {
    return EventfulValue(value)
}

postfix operator ~ {}
public postfix func ~ <T>(inout eventful: EventfulValue<T>) -> T {
    return eventful.get()
}

public class EventfulValue<T>: EventDispatcher, CustomStringConvertible {
    
    public typealias ValueType = T
    public typealias ReturnType = EventInfo<ValueType>
    
    public var event_willChangeValue = Event<ReturnType>()
    public var event_didChangeValue = Event<ReturnType>()
    
    public var value: ValueType {
        willSet {
            let info = EventInfo(value, newValue)
            self.event_willChangeValue.dispatch(info)
        }
        didSet {
            let info = EventInfo(oldValue, value)
            self.event_didChangeValue.dispatch(info)
        }
    }
    
    public func set(value: ValueType) {
        self.value = value
    }
    
    public func get() -> ValueType {
        return self.value
    }
    
    public init(_ value: ValueType) {
        self.value = value
    }
    
    // MARK: Protocol - EventDispatcher
    
    public func removeEventListeners() {
        self.event_willChangeValue.removeListeners()
        self.event_didChangeValue.removeListeners()
    }
    
    // MARK: Protocol - CustomStringConvertible
    
    public var description: String {
        return "EventfulValue: \(self.value)"
    }
    
}
