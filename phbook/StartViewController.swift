//
//  StartViewController.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

enum StartCellIDs: String {
    case contactCell = "contactCell"
}

class StartViewController: BaseViewController {
    let viewModel = StartViewControllerVM()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        self.viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getNumbers()
    }
    
    fileprivate func showSpinner() {
        self.activityIndicator.alpha = 1
        self.activityIndicator.startAnimating()
    }
    
    fileprivate func hideSpinner() {
        self.activityIndicator.alpha = 0
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func refreshButtonHandler(_ sender: UIBarButtonItem) {
        self.viewModel.getNumbers()
    }
    
    @IBAction func addButtonHandler(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "contactListToAddContact", sender: sender)
    }
}

extension StartViewController: StartViewControllerVMDelegate {
    func didStartGetNumbers() {
        self.tableView.reloadData()
        self.showSpinner()
    }
    
    func didReceiveSerializationError() {
        self.hideSpinner()
    }
    
    func didFinishGetNumbers() {
        self.tableView.reloadData()
        self.hideSpinner()
    }
}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED \(indexPath)")
    }
}

extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = self.viewModel.cellsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: StartCellIDs.contactCell.rawValue, for: indexPath) as! ContactCell
        cell.setup(with: cellVM)
        return cell
    }
}
