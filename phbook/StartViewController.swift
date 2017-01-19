//
//  StartViewController.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {
    @IBAction func addButtonHandler(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "contactListToAddContact", sender: sender)
    }
}
