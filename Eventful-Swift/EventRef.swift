//
//  EventRef.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

public class EventRef<T> {
    
    public typealias ValueType = T
    public typealias ListenerType = EventListener<T>
    public typealias HandlerType = ListenerType.HandlerType
    public typealias TokenType = EventToken<T>
    
    private var event: Event<ValueType>
    
    public func addListener(handler: HandlerType) -> TokenType {
        return self.event.addListener(handler)
    }
    
    public func removeListener(token: TokenType) {
        self.event.removeListener(token)
    }
    
    public func removeListeners() {
        self.event.removeListeners()
    }
    
    public func dispatch(value: ValueType) {
        self.event.dispatch(value)
    }
    
    public init(event: Event<ValueType>) {
        self.event = event
    }
    
    public convenience init() {
        self.init(event: Event<ValueType>())
    }
    
}