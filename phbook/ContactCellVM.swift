//
//  ContactCellVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 20.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

class ContactCellVM {
    var nameValue: String
    var lastnameValue: String
    var phoneNumberValue: String
    var commentValue: String
    
    init(contact: Contact) {
        self.nameValue = contact.name ?? ""
        self.lastnameValue = contact.lastname ?? ""
        self.phoneNumberValue = contact.phoneNumber ?? ""
        self.commentValue = contact.comment ?? ""
    }
}
