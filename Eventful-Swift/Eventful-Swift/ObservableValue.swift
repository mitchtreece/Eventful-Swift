//
//  ValueObservable.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

infix operator *= { associativity left precedence 80 }
func *= <T>(inout observable: ObservableValue<T>, value: T) {
    observable.set(value)
}

prefix operator * {}
prefix func * <T>(value: T) -> ObservableValue<T> {
    return ObservableValue(value)
}

postfix operator * {}
postfix func * <T>(inout observable: ObservableValue<T>) -> T {
    return observable.get()
}

struct ObservableValueInfo<T> {
    
    typealias ValueType = T
    
    let oldValue: ValueType
    let newValue: ValueType
    
    init(_ old: ValueType, _ new: ValueType) {
        self.oldValue = old
        self.newValue = new
    }
    
}

struct ObservableValue<T>: EventDispatcher {
    
    typealias ValueType = T
    typealias ObservationReturnType = ObservableValueInfo<ValueType>
    
    var event_willChangeValue = EventRef<ObservationReturnType>()
    var event_didChangeValue = EventRef<ObservationReturnType>()
    
    var value: ValueType {
        willSet {
            let info = ObservableValueInfo(value, newValue)
            self.event_willChangeValue.dispatch(info)
        }
        didSet {
            let info = ObservableValueInfo(oldValue, value)
            self.event_didChangeValue.dispatch(info)
        }
    }
    
    func removeEventListeners() {
        self.event_willChangeValue.removeListeners()
        self.event_didChangeValue.removeListeners()
    }
    
    mutating func set(value: ValueType) {
        self.value = value
    }
    
    func get() -> ValueType {
        return self.value
    }
    
    init(_ value: ValueType) {
        self.value = value
    }
    
}
