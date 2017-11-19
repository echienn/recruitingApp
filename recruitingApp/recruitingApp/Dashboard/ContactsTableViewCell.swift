//
//  ContactsTableViewCell.swift
//  recruitingApp
//
//  Created by Shubham Gupta on 11/19/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
