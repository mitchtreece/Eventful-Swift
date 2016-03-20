//
//  Observable.swift
//  Eventful
//
//  Created by Mitch Treece on 3/16/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import Foundation

public protocol EventDispatcher {
    
    func removeEventListeners()
    
}