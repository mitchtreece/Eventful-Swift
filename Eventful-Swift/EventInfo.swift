//
//  EventInfo.swift
//  Pods
//
//  Created by Mitch Treece on 3/30/16.
//
//

import Foundation

public struct EventInfo<T>: CustomStringConvertible {
    
    public typealias ValueType = T
    
    public let oldValue: ValueType
    public let newValue: ValueType
    
    internal init(_ old: ValueType, _ new: ValueType) {
        self.oldValue = old
        self.newValue = new
    }
    
    public var description: String {
        return "EventInfo: oldValue = \(self.oldValue), newValue = \(self.newValue)"
    }
    
}