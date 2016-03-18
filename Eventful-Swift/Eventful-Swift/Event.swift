//
//  Event.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

struct Event<T> {
    
    typealias ValueType = T
    typealias ListenerType = EventListener<T>
    typealias HandlerType = ListenerType.HandlerType
    typealias TokenType = EventToken<T>
    
    private var listeners = [ListenerType]()
    
    mutating func addListener(handler: HandlerType) -> TokenType {
        let listener = ListenerType(handler: handler)
        self.listeners.append(listener)
        let token = EventToken(listener: listener)
        return token
    }
    
    mutating func removeListener(token: TokenType) {
        
        // We cannot just remove the listener from the array,
        // because to do that our listener class would have
        // to conform to the 'Equatable' protocol. Our EventListener
        // class only has a closure to compare, and that's not
        // allowed. So instead, we'll loop over our listener
        // array and add all elements EXCEPT the listener that
        // wants to be unsubscribed to a new array.
        
        var updatedListeners = [ListenerType]()
        
        for listener in self.listeners {
            if listener !== token.listener {
                updatedListeners.append(listener)
            }
        }
        
        self.listeners = updatedListeners
        
    }
    
    mutating func removeListeners() {
        self.listeners.removeAll()
    }
    
    func dispatch(value: ValueType) {
        for listener in self.listeners {
            listener.handler(value)
        }
    }
    
}