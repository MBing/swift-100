//
//  DetailViewController.swift
//  4 Project
//
//  Created by Martin Demiddel on 31.03.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedFlag = "No Flag Selected"
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: selectedFlag)
    }

}
