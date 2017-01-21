//
//  ServerChangeViewControllerVM.swift
//  phbook
//
//  Created by Alexander Kozharsky on 21.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import Foundation

/** View model for server change view controller */
class ServerChangeViewControllerVM {
    //MARK: Public methods
    /** Returns state for server change switch */
    func getState() -> Bool {
        let serverState = UserDefaults.standard.bool(forKey: "serverState")
        return serverState
    }
    
    /** Saves state for server change switch */
    func saveState(with value: Bool) {
        UserDefaults.standard.set(value, forKey: "serverState")
    }
}
