//
//  Contact.swift
//  recruitingApp
//
//  Created by Shubham Gupta on 11/19/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import Foundation
class Contact{
    let name: String?
    let company: String?
    let email: String?
    let phoneNumber: String?
    let notes: String?
    let status: String?
    
    init(name: String, company: String, email:String, phoneNumber: String, notes: String, status:String) {
        self.name = name
        self.company = company
        self.email = email
        self.phoneNumber = phoneNumber
        self.notes = notes
        self.status = status
    }
    
}
