//
//  ContactCell.swift
//  phbook
//
//  Created by Alexander Kozharsky on 20.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

/** Cell for `Contact` view model */
class ContactCell: UITableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var lastnameValueLabel: UILabel!
    @IBOutlet weak var phoneNumberValueLabel: UILabel!
    @IBOutlet weak var commentValueLabel: UILabel!
    
    //MARK: Public methods
    /**
     Setups cell with view model
     - Parameter viewModel: View model to setup cell with
    */
    func setup(with viewModel: Any) {
        guard let viewModel = viewModel as? ContactCellVM else { return }
        
        self.nameValueLabel.text = viewModel.nameValue
        self.lastnameValueLabel.text = viewModel.lastnameValue
        self.phoneNumberValueLabel.text = viewModel.phoneNumberValue
        self.commentValueLabel.text = viewModel.commentValue
    }
}
