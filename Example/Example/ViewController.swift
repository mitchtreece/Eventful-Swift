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
    var x: ObservableValue<Int> = ~(0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        x.event_didChangeValue.addListener { (info) -> () in
            self.label?.text = "x = \(info.newValue)"
        }
        
        x ~>> 13
        
        let recognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(recognizer)
        
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

