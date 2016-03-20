//
//  EventToken.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

public class EventToken<T> {
    
    public typealias ListenerType = EventListener<T>
    
    internal var listener: ListenerType
    
    internal init(listener: ListenerType) {
        self.listener = listener
    }
    
}