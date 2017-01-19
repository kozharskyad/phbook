//
//  AddViewControllerVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import Alamofire

protocol AddViewControllerVMDelegate: class {
    func didStartSavingContact()
    func didReceiveSerializationError()
    func didReceiveSavingError()
    func didReceiveFillError()
    func didSavedContact()
}

extension AddViewControllerVMDelegate {
    func didStartSavingContact() {}
    func didReceiveSerializationError() {}
    func didReceiveSavingError() {}
    func didReceiveFillError() {}
    func didSavedContact() {}
}

class AddViewControllerVM {
    weak var delegate: AddViewControllerVMDelegate?
    weak var lastRequest: Request?
    
    func save(name: String?, lastname: String?, phoneNumber: String?, comment: String?) {
        self.delegate?.didStartSavingContact()
        
        guard let name = name, !name.isEmpty else {
            self.delegate?.didReceiveFillError()
            return
        }
        
        guard let lastname = lastname, !lastname.isEmpty else {
            self.delegate?.didReceiveFillError()
            return
        }
        
        guard let phoneNumber = phoneNumber, !phoneNumber.isEmpty else {
            self.delegate?.didReceiveFillError()
            return
        }
        
        guard let comment = comment, !comment.isEmpty else {
            self.delegate?.didReceiveFillError()
            return
        }
        
        let newContact = Contact(name: name, lastname: lastname, phoneNumber: phoneNumber, comment: comment)
        
        let parameters: Parameters = newContact.toJSON()
        
        self.lastRequest = Alamofire.request("http://192.168.1.66:3000/api/add", method: .post, parameters: parameters).responseJSON(completionHandler: { response in
            guard let json = response.result.value as? [String: Any] else {
                self.delegate?.didReceiveSerializationError()
                return
            }
            
            guard let result = json["result"] as? String, result == "ok" else {
                self.delegate?.didReceiveSavingError()
                return
            }
            
            self.delegate?.didSavedContact()
        })
    }
}
