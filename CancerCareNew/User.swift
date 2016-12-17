//
//  User.swift
//  CancerCareNew
//
//  Created by Aykut on 16.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import Foundation
import Firebase

struct User {

    let networkRef = NetworkingService()
    let databaseRef = FIRDatabase.database().reference()

    //let currUser = FIRAuth.auth()?.currentUser

    var name = ""
    var surname = ""
    var email = ""
    var password = ""
    var uid = ""
    var main_uid = ""
    var currMood = ""

    func update(name: String, surname: String, password: String, newPassword: String, confirmNewPassword: String) {

        let currUserID = FIRAuth.auth()?.currentUser?.uid

        let userRef = databaseRef.child("users")

        let secondaryUserRef = userRef.child("secondary_users")

        secondaryUserRef.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.hasChild(currUserID!) {

                let mySecondaryUserRef = secondaryUserRef.child(currUserID!)

                self.networkRef.updateUserInfo(userRef: mySecondaryUserRef, name: name, surname: surname, oldPassword: password, newPassword: newPassword, confirmNewPassword: confirmNewPassword)

            } else {

                let myUserRef = userRef.child(currUserID!)

                self.networkRef.updateUserInfo(userRef: myUserRef, name: name, surname: surname, oldPassword: password, newPassword: newPassword, confirmNewPassword: confirmNewPassword)

            }

        }) { (error) in

            print(error.localizedDescription)

        }

    }
    
    func getUserDate() -> String{
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day
        ]
        
        let dateComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        let year = dateComponents.year?.description
        let month = dateComponents.month?.description
        let day = dateComponents.day?.description
        
        var dateKey = ""
        dateKey += day!
        dateKey += month!
        dateKey += year!
        return dateKey
    }

    /*func getCurrentMood(completionBlock: (_ result:String) -> ()) {
        var result = ""
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        let moodRef = databaseRef.child("moods").child(currUserID!)
        
        moodRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let currentDateTime = Date()
            let userCalendar = Calendar.current
            let requestedComponents: Set<Calendar.Component> = [
                .year,
                .month,
                .day
            ]
            
            let dateComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
            
            let year = dateComponents.year?.description
            let month = dateComponents.month?.description
            let day = dateComponents.day?.description
            
            var dateKey = ""
            dateKey += day!
            dateKey += month!
            dateKey += year!
            
            if snapshot.hasChild(dateKey) {
                
                result = dateKey
            
            } else {
                
               result = ""
                
            }
            
        }) { (error) in
            
            print(error.localizedDescription)
            
        }
        completionBlock(result)

        
    }
 */



}
