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
        self.cellsData.removeAll()
        self.delegate?.didStartGetNumbers()
        
        let url = "http://192.168.1.66:3000/api/numbers"
        
        self.lastRequest = Alamofire.request(url).responseJSON(completionHandler: { response in
            guard let json = response.result.value as? [[String: Any]] else {
                self.delegate?.didReceiveSerializationError()
                return
            }
            
            for dict in json {
                if let contact = Contact(JSON: dict) {
                    self.cellsData.append(ContactCellVM(contact: contact))
                }
            }
            
            let deadline = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                self.delegate?.didFinishGetNumbers()
            })
        })
    }
}
