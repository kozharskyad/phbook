//
//  Contact.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import ObjectMapper

class Contact: Mappable {
    var name: String?
    var lastname: String?
    var phoneNumber: String?
    var comment: String?
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.lastname <- map["lastname"]
        self.phoneNumber <- map["phone_number"]
        self.comment <- map["comment"]
    }
    
    required init?(map: Map) {
        
    }
    
    init(name: String, lastname: String, phoneNumber: String, comment: String) {
        self.name = name
        self.lastname = lastname
        self.phoneNumber = phoneNumber
        self.comment = comment
    }
}
