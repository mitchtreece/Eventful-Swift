//
//  EventRef.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

class EventRef<T> {
    
    typealias ValueType = T
    typealias ListenerType = EventListener<T>
    typealias HandlerType = ListenerType.HandlerType
    typealias TokenType = EventToken<T>
    
    private var event: Event<ValueType>
    
    func addListener(handler: HandlerType) -> TokenType {
        return self.event.addListener(handler)
    }
    
    func removeListener(token: TokenType) {
        self.event.removeListener(token)
    }
    
    func removeListeners() {
        self.event.removeListeners()
    }
    
    func dispatch(value: ValueType) {
        self.event.dispatch(value)
    }
    
    init(event: Event<ValueType>) {
        self.event = event
    }
    
    convenience init() {
        self.init(event: Event<ValueType>())
    }
    
}