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
        self.viewModel.save(name: self.nameTextView.text, lastname: self.lastnameTextView.text, phoneNumber: self.phoneNumberTextView.text, comment: self.commentTextView.text)
    }
    
    override func viewDidLoad() {
        self.viewModel.delegate = self
    }
}

extension AddViewController: AddViewControllerVMDelegate {
    func didReceiveFillError() {
        Alert.show(with: "Error", message: "All fields must be filled!")
    }
    
    func didSavedContact() {
        Alert.show(with: "Success", message: "Contact saved!", target: self, dismissAfter: 1, okHandler: nil, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func didReceiveSerializationError() {
        Alert.show(with: "Error", message: "Server sent unreadable data!")
    }
    
    func didReceiveSavingError(errorText: String) {
        Alert.show(with: "Error", message: errorText)
    }
}
