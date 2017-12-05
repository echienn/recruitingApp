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
    
    
    /*TODO:
     Uncomment the following lines when you reach the appriopriate section in the
     README. DO NOT UNCOMMENT THE ONES WITHIN THE NEXT TODO:
     */
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        print("LOOK FOR ")
        print(currentUser)
        id = currentUser?.uid
    }
    
    
    
    /*
     TODO:
     
     Retrieve a list of post ID's that the user has already opened and return them as an array of strings.
     Note that our database is set up to store a set of ID's under the readPosts node for each user.
     Make a query to Firebase using the 'observeSingleEvent' function (with 'of' parameter set to .value) and retrieve the snapshot that is returned. If the snapshot exists, store its value as a [String:AnyObject] dictionary and iterate through its keys, appending the value corresponding to that key to postArray each time. Finally, call completion(postArray).
     */
    func getContacts(completion: @escaping ([String]) -> Void) {
        var postArray: [String] = []
        dbRef.child(id).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                if let userDict = snapshot.value as? [String: Any] {
                    for key in userDict.keys {
                        postArray.append(userDict[key] as! String)
                    }
                }
            }
            completion(postArray)
        })
    }
    
}
