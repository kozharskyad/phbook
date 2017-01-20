//
//  ContactCell.swift
//  phbook
//
//  Created by Alexander Kozharsky on 20.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var lastnameValueLabel: UILabel!
    @IBOutlet weak var phoneNumberValueLabel: UILabel!
    @IBOutlet weak var commentValueLabel: UILabel!
    
    func setup(with viewModel: Any) {
        guard let viewModel = viewModel as? ContactCellVM else { return }
        
        self.nameValueLabel.text = viewModel.nameValue
        self.lastnameValueLabel.text = viewModel.lastnameValue
        self.phoneNumberValueLabel.text = viewModel.phoneNumberValue
        self.commentValueLabel.text = viewModel.commentValue
    }
}
