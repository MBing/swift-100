//
//  Picture.swift
//  StormViewer
//
//  Created by Martin Demiddel on 14.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class Picture: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
