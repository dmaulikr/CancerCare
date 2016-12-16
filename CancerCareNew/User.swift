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





}
