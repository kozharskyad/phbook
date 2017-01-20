//
//  AddViewController.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

class AddViewController: BaseViewController {
    let viewModel = AddViewControllerVM()
    
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var lastnameTextView: UITextField!
    @IBOutlet weak var phoneNumberTextView: UITextField!
    @IBOutlet weak var commentTextView: UITextField!
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonHandler(_ sender: UIBarButtonItem) {
        if let lastRequest = self.viewModel.lastRequest {
            lastRequest.cancel()
        }
        
        self.viewModel.save(name: self.nameTextView.text, lastname: self.lastnameTextView.text, phoneNumber: self.phoneNumberTextView.text, comment: self.commentTextView.text)
    }
    
    override func viewDidLoad() {
        self.viewModel.delegate = self
    }
    
    fileprivate func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let alertOKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertOKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AddViewController: AddViewControllerVMDelegate {
    func didReceiveFillError() {
        self.showAlert(title: "Error", message: "All fields must be filled!")
    }
    
    func didSavedContact() {
        self.showAlert(title: "Success", message: "Contact saved!", handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func didReceiveSerializationError() {
        self.showAlert(title: "Error", message: "Server sent unreadable data!")
    }
    
    func didReceiveSavingError(errorText: String) {
        self.showAlert(title: "Error", message: errorText)
    }
}
