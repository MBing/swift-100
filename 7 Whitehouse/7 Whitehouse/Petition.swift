//
//  Petition.swift
//  7 Whitehouse
//
//  Created by Martin Demiddel on 08.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
