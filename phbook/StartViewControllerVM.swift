//
//  StartViewControllerVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import Alamofire

protocol StartViewControllerVMDelegate: class {
    func didStartGetNumbers()
    func didReceiveSerializationError()
    func didFinishGetNumbers()
}

extension StartViewControllerVMDelegate {
    func didStartGetNumbers() {}
    func didReceiveSerializationError() {}
    func didFinishGetNumbers() {}
}

class StartViewControllerVM {
    weak var delegate: StartViewControllerVMDelegate?
    var cellsData: [ContactCellVM] = []
    var lastRequest: Request?
    
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
