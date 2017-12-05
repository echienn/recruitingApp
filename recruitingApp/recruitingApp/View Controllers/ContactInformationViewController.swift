//
//  ContactInformationViewController.swift
//  recruitingApp
//
//  Created by Emily Zhong on 11/19/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import UIKit

class ContactInformationViewController: UIViewController {
    @IBOutlet weak var contactName: UITextField!
    
    @IBOutlet weak var contactCompany: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    
    @IBOutlet weak var contactPhoneNumber: UITextField!
    @IBOutlet weak var contactNotes: UITextView!
    
    var nameField : String = ""
    var companyField: String = ""
    var emailField: String = ""
    var phoneNumberField: String = ""
    var notesField: String = ""
    
    
    @IBAction func addContact(_ sender: Any) {
        if let name = contactName {
            nameField = name.text!
        }
        if let company = contactCompany {
            companyField = company.text!
        }
        if let email = contactEmail {
            emailField = email.text!
        }
        if let phoneNumber = contactPhoneNumber {
            phoneNumberField = phoneNumber.text!
        }
        if let notes = contactNotes {
            notesField = notes.text
        }
        
        
        if (nameField == "" || companyField == "" || emailField == "") {
            let alert = UIAlertController(title: "Invalid Contact Information", message: "You must provide at least the Name, Company, and Email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            print("ENTERED First ELSE CASE")
            print(nameField)
        
            let newContact: Contact = Contact(name: nameField, company: companyField, email: emailField, phoneNumber: phoneNumberField, notes: notesField, status: "Haven't Applied");
            
            print(companyList)
            print(contactBook)
            print(companyList.contains(companyField))
            if companyList.contains(companyField) {
                print(companyField)
                contactBook[companyField]!.append(newContact)
            } else {
                print(emailField)
                companyList.append(companyField)
                contactBook[companyField] = []
                contactBook[companyField]!.append(newContact)
                
            }
            let alert = UIAlertController(title: "Contact Added!", message: nameField + " has been added to your contact book", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (action) in
                self.performSegue(withIdentifier: "unwindToDashboard", sender: self)
            }))
            recruitingApp.addContact(recruiter_name: nameField, recruiter_company: companyField, recruiter_email: emailField, recruiter_phonenumber: phoneNumberField, current_status: "Haven't Applied")
            self.present(alert, animated: true, completion: nil)

            print("AFTER ADDING CONTACT")
            print(companyList)
            print(contactBook)
            
        }
        //if let name = contactName
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        //Looks for single or multiple taps.
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ContactInformationViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
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
