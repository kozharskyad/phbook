//
//  BackendResult.swift
//  phbook
//
//  Created by Alexander Kozharsky on 21.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import ObjectMapper

/** Backend network response model */
class BackendResult: Mappable {
    //MARK: Public model fields
    var result: String?
    
    //MARK: Init
    required init?(map: Map) {
        
    }
    
    //MARK: Mapping
    func mapping(map: Map) {
        self.result <- map["result"]
    }
}
