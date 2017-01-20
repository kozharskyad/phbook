//
//  Contact.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import ObjectMapper

/**
 Standard contact model
*/
class Contact: Mappable {
    // MARK: Model fields
    var name: String?
    var lastname: String?
    var phoneNumber: String?
    var comment: String?
    
    //MARK: Mapping
    func mapping(map: Map) {
        self.name <- map["name"]
        self.lastname <- map["lastname"]
        self.phoneNumber <- map["phone_number"]
        self.comment <- map["comment"]
    }
    
    //MARK: Init
    required init?(map: Map) {
        
    }
    
    /**
     Initialization function for `Contact` model
     
     - Parameter name: First name
     - Parameter lastname: Last name
     - Parameter phoneNumber: Mobile phone number
     - Parameter comment: User commentary
    */
    init(name: String, lastname: String, phoneNumber: String, comment: String) {
        self.name = name
        self.lastname = lastname
        self.phoneNumber = phoneNumber
        self.comment = comment
    }
}
