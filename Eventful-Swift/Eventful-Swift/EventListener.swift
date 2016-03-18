//
//  EventSubscription.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

class EventListener<T> {
    
    typealias ValueType = T
    typealias HandlerType = (ValueType) -> ()
    
    internal var handler: HandlerType
    
    init(handler h: HandlerType) {
        self.handler = h
    }
    
}