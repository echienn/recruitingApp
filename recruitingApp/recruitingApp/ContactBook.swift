//
//  ContactBook.swift
//  recruitingApp
//
//  Created by Shubham Gupta on 11/19/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import Foundation

var companyList:[String] = []
var contactBook: [String: [Contact]] = [:]


func getRecruiterFromIndexPath(indexPath: IndexPath) -> Contact? {
    let sectionName = companyList[indexPath.section]
    if let companyArray = contactBook[sectionName] {
        return companyArray[indexPath.row]
    }
    print("No post at index \(indexPath.row)")
    return nil
}
