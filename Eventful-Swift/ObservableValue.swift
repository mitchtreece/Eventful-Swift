//
//  ValueObservable.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

infix operator ~>> { associativity left precedence 80 }
public func ~>> <T>(inout observable: ObservableValue<T>, value: T) {
    observable.set(value)
}

prefix operator ~ {}
public prefix func ~ <T>(value: T) -> ObservableValue<T> {
    return ObservableValue(value)
}

postfix operator ~ {}
public postfix func ~ <T>(inout observable: ObservableValue<T>) -> T {
    return observable.get()
}

public struct ObservableValueInfo<T> {
    
    public typealias ValueType = T
    
    public let oldValue: ValueType
    public let newValue: ValueType
    
    internal init(_ old: ValueType, _ new: ValueType) {
        self.oldValue = old
        self.newValue = new
    }
    
}

public struct ObservableValue<T>: EventDispatcher {
    
    public typealias ValueType = T
    public typealias ObservationReturnType = ObservableValueInfo<ValueType>
    
    public var event_willChangeValue = EventRef<ObservationReturnType>()
    public var event_didChangeValue = EventRef<ObservationReturnType>()
    
    public var value: ValueType {
        willSet {
            let info = ObservableValueInfo(value, newValue)
            self.event_willChangeValue.dispatch(info)
        }
        didSet {
            let info = ObservableValueInfo(oldValue, value)
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
