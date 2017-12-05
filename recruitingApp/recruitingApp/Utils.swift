//
//  Utils.swift
//  recruitingApp
//
//  Created by Neha Kunjal on 12/4/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


var contacts: [String:[Contact]] = [:]

let currentUser = CurrentUser()
var contactCompanies: [String] = []

func getPostFromIndexPath(indexPath: IndexPath) -> Contact? {
        let sectionName = contactCompanies[indexPath.section]
        if let postsArray = contacts[sectionName] {
            return postsArray[indexPath.row]
        }
        print("No post at index \(indexPath.row)")
        return nil
}

func clearContacts() {
    contacts = [:]
}


func addContactToContacts(contact: Contact) {
    if contacts[contact.company!] == nil {
        contactCompanies.append(contact.company!)
        contacts[contact.company!] = [contact]
    }
    else {
        contacts[contact.company!]!.append(contact)
    }
}

/*
 TODO:
 
 Store the data for a new post in the Firebase database.
 Make sure you understand the hierarchy of the Posts tree before attempting to write any data to Firebase!
 Each post node contains the following properties:
 
 - (string) imagePath: corresponds to the location of the image in the storage module. This is already defined for you below.
 - (string) thread: corresponds to which feed the image is to be posted to.
 - (string) username: corresponds to the display name of the current user who posted the image.
 - (string) date: the exact time at which the image is captured as a string
 Note: Firebase doesn't allow us to store Date objects, so we have to represent the date as a string instead. You can do this by creating a DateFormatter object, setting its dateFormat (check Constants.swift for the correct date format!) and then calling dateFormatter.string(from: Date()).
 
 Create a dictionary with these four properties and store it as a new child under the Posts node (you'll need to create a child using an auto ID)
 
 Finally, save the actual data to the storage module by calling the store function below.
 
 Remember, DO NOT USE ACTUAL STRING VALUES WHEN REFERENCING A PATH! YOU SHOULD ONLY USE THE CONSTANTS DEFINED IN STRINGS.SWIFT
 
 @IBOutlet var recruiter_name: UILabel!
 @IBOutlet var recruiter_company: UILabel!
 @IBOutlet var recruiter_email: UILabel!
 @IBOutlet weak var currentStatus: UILabel!
 @IBOutlet weak var currentStatusImage: UIImageView!
 */
func addContact(recruiter_name: String, recruiter_company: String, recruiter_email: String, recruiter_phonenumber: String, current_status: String) {
    // Uncomment the lines beneath this one if you've already connected Firebase:
    let dbRef = Database.database().reference()
    //If we are going to add image to contact this is needed
    /*
    let data = UIImageJPEGRepresentation(postImage, 1.0)
    let path = "Images/\(UUID().uuidString)"
    */
    //If we need date?
    /*
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.A"
    let dateString = dateFormatter.string(from: Date())
     */
    //let path = "Contacts/\(UUID().uuidString)"
    let contactDict: [String:AnyObject] = ["recruiter_name": recruiter_name as AnyObject,
                                        "recruiter_company": recruiter_company as AnyObject,
                                        "recruiter_email": recruiter_email as AnyObject,
                                        "current_status": current_status as AnyObject,
                                        "recruiter_phonenumber": recruiter_phonenumber as AnyObject]
    // YOUR CODE HERE
    dbRef.child(currentUser.id).childByAutoId().setValue(contactDict)
    //I think this is for images
    //store(data: postDict, toPath: path)
}


// TODO:
// Uncomment the lines inside this function. This is the function that actually sends
// your data to Firebase's Storage to store it using the given 'path' as it's
// reference.
//
func store(data: Data?, toPath path: String) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).putData(data!, metadata: nil) { (metadata, error) in
        if let error = error {
            print(error)
        }
    }
}




/*
 TODO:
 
 This function should query Firebase for all posts and return an array of Post objects.
 You should use the function 'observeSingleEvent' (with the 'of' parameter set to .value) to get a snapshot of all of the nodes under "Posts".
 If the snapshot exists, store its value as a dictionary of type [String:AnyObject], where the string key corresponds to the ID of each post.
 
 Then, make a query for the user's read posts ID's. In the completion handler, complete the following:
 - Iterate through each of the keys in the dictionary
 - For each key:
 - Create a new Post object, where Posts take in a key, username, imagepath, thread, date string, and read property. For the read property, you should set it to true if the key is contained in the user's read posts ID's and false otherwise.
 - Append the new post object to the post array.
 - Finally, call completion(postArray) to return all of the posts.
 - If any part of the function fails at any point (e.g. snapshot does not exist or snapshot.value is nil), call completion(nil).
 
 Remember to use constants defined in Strings.swift to refer to the correct path!
 */
func getContacts(user: CurrentUser, completion: @escaping ([Contact]?) -> Void) {
    print("get contacts was called (must actually deal with this")
    let dbRef = Database.database().reference()
    var postArray: [Contact] = []
    dbRef.child(currentUser.id).observeSingleEvent(of: .value, with: { snapshot -> Void in
        if snapshot.exists() {
            if let posts = snapshot.value as? [String:AnyObject] {
                    for postKey in posts.keys {
                        let contactInfo: [String:String] = posts[postKey] as! [String : String]
                        postArray.append(Contact(name: contactInfo["recruiter_name"]!, company: contactInfo["recruiter_company"]!, email:contactInfo["recruiter_email"]!, phoneNumber: contactInfo["recruiter_phonenumber"]!, notes: "", status: contactInfo["current_status"]!))

                }
                    completion(postArray)
            }} else {
            completion(nil)
        }
        })
}

// TODO:
// Uncomment the lines in the function when you reach the appriopriate par in the README.
func getDataFromPath(path: String, completion: @escaping (Data?) -> Void) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).getData(maxSize: 5 * 1024 * 1024) { (data, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
            completion(data)
        } else {
            completion(nil)
        }
    }
}


