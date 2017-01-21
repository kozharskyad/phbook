//
//  ServerChangeViewController.swift
//  phbook
//
//  Created by Alexander Kozharsky on 21.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

/** Provides easy backend server change */
class ServerChangeViewController: BaseViewController {
    //MARK: Private properties
    fileprivate let viewModel = ServerChangeViewControllerVM()
    
    //MARK: IBOutlets
    @IBOutlet weak var serverSwitch: UISwitch!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serverSwitch.setOn(self.viewModel.getState(), animated: false)
    }
    
    //MARK: Close button handler
    @IBAction func closeButtonHandler(_ sender: UIBarButtonItem) {
        self.viewModel.saveState(with: self.serverSwitch.isOn)
        self.dismiss(animated: true, completion: nil)
    }
}
