//
//  AddViewControllerVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import Alamofire

/** Add view controller view model delegate methods */
protocol AddViewControllerVMDelegate: class {
    func didStartSavingContact() /** Fires when contact saving started */
    func didReceiveSerializationError() /** Fires when response data cannot serialize as JSON */
    func didReceiveSavingError(errorText: String) /** Fires when network error occured */
    func didReceiveFillError() /** Fires when fields incostistence occured */
    func didSavedContact() /** Fires when contact successfuly saved */
}

/** Add view controller view model delegate optional functions bindings */
extension AddViewControllerVMDelegate {
    func didStartSavingContact() {}
    func didReceiveSerializationError() {}
    func didReceiveSavingError(errorText: String) {}
    func didReceiveFillError() {}
    func didSavedContact() {}
}

/** Add view controller view model */
class AddViewControllerVM {
    //MARK: Public properties
    weak var delegate: AddViewControllerVMDelegate?
    weak var lastRequest: Request?
    
    //MARK: Public methods
    /** 
     Save contact function
     - Parameter name: Contact first name
     - Parameter lastname: Contact last name
     - Parameter phoneNumber: Contact phone number
     - Parameter comment: User's commentary
    */
    func save(name: String?, lastname: String?, phoneNumber: String?, comment: String?) {
        self.delegate?.didStartSavingContact()
        
        if let lastRequest = self.lastRequest {
            lastRequest.cancel()
        }
        
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
        
        self.lastRequest = Network.request(apiCommand: "add", model: BackendResult.self, method: .post, parameters: parameters, completion: { _, models, error in
            guard error == nil else {
                self.delegate?.didReceiveSavingError(errorText: error?.localizedDescription ?? "Undefined error")
                return
            }
            
            guard let models = models,
                let resultModel = models.first,
                let resultString = resultModel.result,
                resultString == "ok" else {
                self.delegate?.didReceiveSerializationError()
                return
            }
            
            self.delegate?.didSavedContact()
        })
    }
}
