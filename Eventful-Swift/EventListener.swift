//
//  EventSubscription.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

public class EventListener<T> {
    
    public typealias ValueType = T
    public typealias HandlerType = (ValueType) -> ()
    
    internal var handler: HandlerType
    
    internal init(handler h: HandlerType) {
        self.handler = h
    }
    
}