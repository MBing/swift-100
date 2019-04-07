//
//  ViewController.swift
//  6 Constraints B
//
//  Created by Martin Demiddel on 07.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = createLabel(bgColor: UIColor.red, labelText: "THESE")
        let label2 = createLabel(bgColor: UIColor.cyan, labelText: "ARE")
        let label3 = createLabel(bgColor: UIColor.yellow, labelText: "SOME")
        let label4 = createLabel(bgColor: UIColor.green, labelText: "AWESOME")
        let label5 = createLabel(bgColor: UIColor.orange, labelText: "LABELS")

        // Visual Formatting Language example below
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        let metrics = ["labelHeight": 88]
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        // Same as above but with Auto Layout Anchors
        var previous: UILabel?
        let labels = [label1, label2, label3, label4, label5]
        for label in labels {
            // label.widthAnchor.constraint is usually an easier way to pin to parent view
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            // leading & trailing Anchor is a more explicit way way to pin to the edges of the parent view
            let safeArea = view.safeAreaLayoutGuide
            label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            // if previous is not nil, then the new topAnchor should be set to the previous bottom with 10 whitespace
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
            }

            // make sure the last label doesn't overflow on the bottom -> only necessary if the height is not kept within boundaries
//            if label == labels.last {
//                label.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
//            }
            
            previous = label
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func createLabel(_ AutoResize: Bool = false, bgColor: UIColor, labelText: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = AutoResize
        label.backgroundColor = bgColor
        label.text = labelText
        
        view.addSubview(label)
        
        return label
    }
}

