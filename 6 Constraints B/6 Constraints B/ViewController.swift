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
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

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
}

