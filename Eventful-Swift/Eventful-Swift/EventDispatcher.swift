//
//  Observable.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

protocol EventDispatcher {
    
    func removeEventListeners()
    
}

// Observable's:
// -- Value Observation
// -- Object Observation (initialization | deallocation)