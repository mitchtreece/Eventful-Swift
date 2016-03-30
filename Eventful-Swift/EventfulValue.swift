//
//  EventfulValue.swift
//  Eventful
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

public struct EventfulValueInfo<T> {
    
    public typealias ValueType = T
    
    public let oldValue: ValueType
    public let newValue: ValueType
    
    internal init(_ old: ValueType, _ new: ValueType) {
        self.oldValue = old
        self.newValue = new
    }
    
}

public struct EventfulValue<T>: EventDispatcher {
    
    public typealias ValueType = T
    public typealias ReturnType = EventfulValueInfo<ValueType>
    
    public var event_willChangeValue = EventRef<ReturnType>()
    public var event_didChangeValue = EventRef<ReturnType>()
    
    public var value: ValueType {
        willSet {
            let info = EventfulValueInfo(value, newValue)
            self.event_willChangeValue.dispatch(info)
        }
        didSet {
            let info = EventfulValueInfo(oldValue, value)
            self.event_didChangeValue.dispatch(info)
        }
    }
    
    public func removeEventListeners() {
        self.event_willChangeValue.removeListeners()
        self.event_didChangeValue.removeListeners()
    }
    
    public mutating func set(value: ValueType) {
        self.value = value
    }
    
    public func get() -> ValueType {
        return self.value
    }
    
    public init(_ value: ValueType) {
        self.value = value
    }
    
}
