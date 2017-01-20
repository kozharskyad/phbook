//
//  ContactCellVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 20.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

/** Cell view model for `Contact` model */
class ContactCellVM {
    //MARK: Public properties
    var nameValue: String
    var lastnameValue: String
    var phoneNumberValue: String
    var commentValue: String
    
    //MARK: Init
    /**
     Initialization function for `Contact` cell view model
     - Parameter contact: `Contact` model to initialize the view model
    */
    init(contact: Contact) {
        self.nameValue = contact.name ?? ""
        self.lastnameValue = contact.lastname ?? ""
        self.phoneNumberValue = contact.phoneNumber ?? ""
        self.commentValue = contact.comment ?? ""
    }
}
