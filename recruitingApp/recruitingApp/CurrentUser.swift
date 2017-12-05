//
//  CurrentUser.swift
//  recruitingApp
//
//  Created by Neha Kunjal on 12/4/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CurrentUser {
    
    var id: String!
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        print("LOOK FOR ")
        print(currentUser)
        id = currentUser?.uid
    }
    
}
