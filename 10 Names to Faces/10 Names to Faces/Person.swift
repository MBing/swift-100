//
//  Person.swift
//  10 Names to Faces
//
//  Created by Martin Demiddel on 14.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
