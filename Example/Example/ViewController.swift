//
//  ViewController.swift
//  Example
//
//  Created by Mitch Treece on 3/18/16.
//  Copyright © 2016 Mitch Treece. All rights reserved.
//

import UIKit
import EventfulSwift

class ViewController: UIViewController {

    @IBOutlet var label: UILabel?
    var x: ObservableValue<Int> = ~(13)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        x.event_didChangeValue.addListener { (info) -> () in
            self.label?.text = "x = \(info.newValue)"
        }
                
        let recognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(recognizer)
        
        createPerson()
        
    }
    
    func createPerson() {
        
        var person: Person? = Person(name: "Bob", age: 23)
        person?.event_died.addListener { (value: Bool) in
            print("Bob died 😭")
        }
        
        print("\(person?.name) was born 😄")
        print("\(person?.name) is living his life...")
        
        person = nil
        
    }
    
    func handleTap(recognizer: UIGestureRecognizer) {
        let random = Int.random(0...100)
        x ~>> random
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension Int {
    
    static func random(range: Range<Int>) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
}

