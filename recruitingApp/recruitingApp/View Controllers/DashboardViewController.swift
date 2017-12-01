//
//  DashboardViewController.swift
//  recruitingApp
//
//  Created by Emily Zhong on 11/19/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.

//sources: https://www.andrewcbancroft.com/2014/08/25/send-email-in-app-using-////mfmailcomposeviewcontroller-with-swift/

//

import UIKit
import MessageUI
import Foundation

class DashboardViewController: UIViewController, MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    var selectedRecruiter: Contact?
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contactsTableView.reloadData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactBook[companyList[section]]!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactsTableViewCell
        print("indexPathRow IN Dashboard: ", indexPath.row)
        if let recruiter = getRecruiterFromIndexPath(indexPath: indexPath) {
            cell.contactName.text = recruiter.name
            cell.contactCompany.text = recruiter.company
            cell.contactPhoto.image = UIImage(named: "blankUser")
            cell.contactStatus.text = recruiter.status
        }
        //var recruiter : Contact = getRecruiterFromIndexPath(indexPath: indexPath)!
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int  {
        return companyList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return companyList[section]
    }
    
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? ContactsTableViewCell {
            if let recruiter = getRecruiterFromIndexPath(indexPath: indexPath) {
                selectedRecruiter = recruiter;
            }
        }
         performSegue(withIdentifier: "openContact", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "openContact" {
                if let dest = segue.destination as? ContactDetailsViewController {
                    dest.recruiter = selectedRecruiter
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToDashboard(segue:UIStoryboardSegue) { }
    
    /*
    @IBAction func SendEmail(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"]) //change this to the email in the contact
        //mailComposerVC.setSubject("Sending you an in-app e-mail...")
        //mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
  */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
