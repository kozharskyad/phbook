//
//  StartViewControllerVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import Alamofire

//MARK: View model delegate methods
protocol StartViewControllerVMDelegate: class {
    /** Fires when all cell data removed */
    func didStartGetNumbers()
    /** Fires when json dictionary unwrapping unsuccessfull */
    func didReceiveSerializationError()
    /** Fires when cells data array filled with view models */
    func didFinishGetNumbers()
}

//MARK: Optional methods delegate bindings
extension StartViewControllerVMDelegate {
    func didStartGetNumbers() {}
    func didReceiveSerializationError() {}
    func didFinishGetNumbers() {}
}

/** Contact list view controller view model */
class StartViewControllerVM {
    //MARK: Public properties
    weak var delegate: StartViewControllerVMDelegate?
    var cellsData: [ContactCellVM] = []
    var lastRequest: Request?
    
    //MARK: Public methods
    /** Fills cells data array with `Contact` cell view models */
    func getNumbers() {
        if let lastRequest = self.lastRequest {
            lastRequest.cancel()
        }
        
        self.cellsData.removeAll()
        self.delegate?.didStartGetNumbers()
        
        self.lastRequest = Network.request(apiCommand: "numbers", model: Contact.self, completion: { _, models, error in
            guard error == nil else {
                self.delegate?.didReceiveSerializationError()
                return
            }
            
            guard let models = models else {
                self.delegate?.didReceiveSerializationError()
                return
            }
            
            for model in models {
                self.cellsData.append(ContactCellVM(contact: model))
            }
            
            self.delegate?.didFinishGetNumbers()
        })
    }
}
