//
//  StartViewController.swift
//  phbook
//
//  Created by Alexander Kozharsky on 19.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import UIKit

/** Cells identificators enumeration */
enum StartCellIDs: String {
    case contactCell = "contactCell"
}

/** Contact list view controller implementation */
class StartViewController: BaseViewController {
    //MARK: Private properties
    fileprivate let viewModel = StartViewControllerVM()
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        self.viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getNumbers()
    }
    
    //MARK: Private methods
    /** Shows loading spinner on table */
    fileprivate func showSpinner() {
        self.activityIndicator.alpha = 1
        self.activityIndicator.startAnimating()
    }
    
    /** Hides loading table spinner */
    fileprivate func hideSpinner() {
        self.activityIndicator.alpha = 0
        self.activityIndicator.stopAnimating()
    }
    
    //MARK: Button handlers
    @IBAction func refreshButtonHandler(_ sender: UIBarButtonItem) {
        self.viewModel.getNumbers()
    }
    
    @IBAction func addButtonHandler(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "contactListToAddContact", sender: sender)
    }
}

//MARK: StartViewControllerVMDelegate
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

//MARK: UITableViewDelegate
extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Make proper cell actions and handles
        print("SELECTED \(indexPath)")
    }
}

//MARK: UITableViewDataSource
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
