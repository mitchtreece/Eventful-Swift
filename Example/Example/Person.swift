//
//  Person.swift
//  Example
//
//  Created by Mitch Treece on 3/20/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation
import EventfulSwift

class Person: EventDispatcher, CustomStringConvertible {
    
    var name: String
    var age: Int
    var event_died = Event<Bool>()
    
    func removeEventListeners() {
        self.event_died.removeListeners()
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    deinit {
        self.event_died.dispatch(true)
    }
    
    var description: String {
        return "Person(name: \(self.name), age: \(self.age))"
    }
    
}