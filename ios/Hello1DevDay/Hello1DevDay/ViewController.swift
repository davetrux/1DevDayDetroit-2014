//
//  ViewController.swift
//  Hello1DevDay
//
//  Created by David Truxall on 10/24/14.
//  Copyright (c) 2014 Hewlett-Packard Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func didTouchButton(sender: UIButton) {
        var speakerText = "Yo speaker"
        var audienceText = "Yo audience"
        
        if(yoLabel.text != speakerText){
            yoLabel.text = speakerText
        } else {
            yoLabel.text = audienceText
        }
    }
}

