//
//  CircleButton.swift
//  Scribe
//
//  Created by Brett Mayer on 7/21/17.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import UIKit

@IBDesignable  //this shows us the graphical update within the main storyboard
class CircleButton: UIButton {

    
    //now we can edit this in storyboard
    @IBInspectable var cornerRadius: CGFloat = 30.0 {  //square is 60 high, so cornerRadius of 30 makes it round!
        didSet {  //property observer, called immediately after property value changes (willSet is before it changes)
            setupView()
        }
    }
    
    //we can make the changed in IB and see it when we run app, but to see the changes appear in IB:
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView () {
        layer.cornerRadius = cornerRadius
    }

}
