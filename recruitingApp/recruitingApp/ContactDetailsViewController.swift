//
//  ContactDetailsViewController.swift
//  recruitingApp
//
//  Created by Elaine Chien on 11/28/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    var recruiter: Contact!
    
    @IBOutlet var recruiter_name: UILabel!
    @IBOutlet var recruiter_company: UILabel!
    @IBOutlet var recruiter_email: UILabel!
    @IBAction func sendEmail(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recruiter_name.text = recruiter.name
        recruiter_company.text = recruiter.company
        recruiter_email.text = recruiter.email
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
