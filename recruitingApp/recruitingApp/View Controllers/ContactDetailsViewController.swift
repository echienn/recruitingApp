//
//  ContactDetailsViewController.swift
//  recruitingApp
//
//  Created by Elaine Chien on 11/28/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

//sources: https://www.andrewcbancroft.com/2014/08/25/send-email-in-app-using-////mfmailcomposeviewcontroller-with-swift/

import UIKit
import MessageUI
import Foundation

class ContactDetailsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var recruiter: Contact!
    
    @IBOutlet var recruiter_name: UILabel!
    @IBOutlet var recruiter_company: UILabel!
    @IBOutlet var recruiter_email: UILabel!
    @IBOutlet weak var currentStatus: UILabel!
    @IBOutlet weak var currentStatusImage: UIImageView!
    
    @IBAction func sendEmail(_ sender: UIButton) {
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
        if let filled_email = recruiter.email{
        mailComposerVC.setToRecipients([filled_email])
        }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        recruiter_name.text = recruiter.name
        recruiter_company.text = recruiter.company
        recruiter_email.text = recruiter.email
        currentStatus.text = recruiter.status
        if (recruiter.status == "offer" || recruiter.status == "accepted") {
            currentStatusImage.image = UIImage(named: "accepted.png")
        } else if (recruiter.status == "rejected") {
            currentStatusImage.image = UIImage(named: "rejected.png")
        } else {
            currentStatusImage.image = UIImage(named: "pending.png")
        }
        

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
