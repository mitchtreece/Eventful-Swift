//
//  EventToken.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

class EventToken<T> {
    
    typealias ListenerType = EventListener<T>
    
    internal var listener: ListenerType
    
    init(listener: ListenerType) {
        self.listener = listener
    }
    
}