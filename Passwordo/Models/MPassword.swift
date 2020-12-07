//
//  MPassword.swift
//  Passwordo
//
//  Created by Boris Goncharov on 7/12/20.
//  Copyright © 2020 Boris Goncharov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MPassword: Object {
    
    @objc dynamic var itemName: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var serviceURL: String = ""
    @objc dynamic var imageURL: String = ""

    
    convenience init(itemName: String, userName: String, password: String, serviceURL: String, imageURL: String) {
        self.init()
        self.itemName = itemName
        self.userName = userName
        self.password = password
        self.serviceURL = serviceURL
        self.imageURL = imageURL
    }
}
