//
//  NetworkingService.swift
//  CancerCareNew
//
//  Created by Aykut on 25.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct NetworkingService {

    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    let currDate = Date()
    let formatter = DateFormatter()
    //func hasChild(_ childPathString: String) -> Bool

    private func saveInfo(user: FIRUser!, name: String, surname: String, email: String, password: String){
        //create user info
        let userInfo = ["email": user.email, "name": name, "surname": surname, "password": password, "uid": user.uid]

        //create user reference
        let userRef = databaseRef.child("users").child(user.uid)
        
        //Save the user info in the database
        userRef.setValue(userInfo)

        signIn(email: user.email!, password: password)
        
    }

    private func saveInfo2(user: FIRUser!, name: String, surname: String, email: String, password: String, mainUID: String){
        
        //create user info
        
        let userInfo = ["email": user.email, "name": name, "surname": surname, "password": password, "uid": user.uid, "main_uid": mainUID]
        
        //create user reference
        
        let userRef = databaseRef.child("users/secondary_users").child(user.uid)
    
        //Save the user info in the database
        
        userRef.setValue(userInfo)
        
        //signIn(email: user.email!, password: password)
        
    }
    
    func signIn(email: String, password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in

            if error == nil {
                
                if let user = user {
                    
                    print("giriş başarılı")
                    
                }
                
            } else {
                
                print(error!.localizedDescription)
                
            }
            
        })
        
    }
    
    
    func signUp(name: String, surname: String, email: String, password: String){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            
            if error==nil {
                
                self.saveInfo(user: user, name: name, surname: surname, email: email, password: password)
                
            }else {
                
                print(error!.localizedDescription)
                
            }
            
        })
        
    }
    
    func signUp2(name: String, surname: String, email: String, password: String, mainUID: String){
       
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            
            if error==nil {
                
                self.saveInfo2(user: user, name: name, surname: surname, email: email, password: password, mainUID: mainUID)
                
            }else {
                
                print(error!.localizedDescription)
                
            }
            
        })
        
    }
    
    func isSecondaryUser (user: FIRUser) -> Bool{
        
        var result = false
        
        let currUserID = user.uid
        
        let secondaryUsersRef = databaseRef.child("users").child("secondary_users")
        
        
        
        secondaryUsersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild(currUserID) {
                
                return
                
            } else {
                
                return
                
            }
            
        }) { (error) in
            
            print(error.localizedDescription)
            
        }
        
        return result
        
    }
    
    
    func updateUserInfo(userRef: FIRDatabaseReference, name: String, surname: String, oldPassword: String, newPassword: String, confirmNewPassword: String) -> Int {
        
        let currUser = FIRAuth.auth()?.currentUser
        //var userRef = databaseRef.child("users").child(currUserID)
        /*
         if isSecondaryUser(user: user) {
         userRef = databaseRef.child("users/secondary_users").child(currUserID)
         }
         */
        var result = 0
        if name != "" {
            userRef.child("name").setValue(name)
        }
        
        
        if surname != "" {
            userRef.child("surname").setValue(surname)
        }
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let currPassword = value?["password"] as? String?
            //currPasswordString = currPassword!! // :D
            if currPassword! == oldPassword && newPassword == confirmNewPassword && newPassword != "" {
                currUser?.updatePassword(newPassword, completion: { error in
                    if error != nil {
                        result = -1
                        return
                            print(error?.localizedDescription)
                    } else {
                        print("Yeni bilgiler başarıyla güncellendi")
                        result = 1
                        userRef.child("password").setValue(newPassword)
                        return
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
            result = -1
            return
        }
        return result
    }
    
    // name, surname, birthdate, diag, diagdate, treloc, tretype
    
    func updateChildInfo(user: FIRUser, name: String, surname: String, birthDate: String, diagnosis: String, diagnosisDate: String, treatmentLocation: String, treatmentType: String){
        let userID = user.uid
        let childRef = databaseRef.child("children").child(userID)
        if name != "" {
            childRef.child("name").setValue(name)
        }
        if surname != "" {
            childRef.child("surname").setValue(surname)
        }
        if birthDate != "" {
            childRef.child("birthDate").setValue(birthDate)
        }
        if diagnosis != "" {
            childRef.child("diagnosis").setValue(diagnosis)
        }
        if diagnosisDate != "" {
            
            childRef.child("diagnosisDate").setValue(diagnosisDate)
            
        }
        
        if treatmentLocation != "" {
            
            childRef.child("treatmentLocation").setValue(treatmentLocation)
            
        }
        
        if treatmentType != "" {
            
            childRef.child("treatmentType").setValue(treatmentType)
            
        }
        
    }
    
    
    
    func updateChildBlood(user: FIRUser, rbc: String, wbc: String, anc: String){
        
        
        
        let userID = user.uid
        
        let vitalRef = databaseRef.child("vitals").child(userID).childByAutoId()
        
        
        
        let rbcRef = vitalRef.child("rbc")
        
        let wbcRef = vitalRef.child("wbc")
        
        let ancRef = vitalRef.child("anc")
        
        
        
        if rbc != "" {
            
            rbcRef.setValue(rbc)
            
        }
        
        
        
        if wbc != "" {
            
            wbcRef.setValue(wbc)
            
        }
        
        
        
        if anc != "" {
            
            ancRef.setValue(anc)
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    func updateChildTemp(user: FIRUser, temp: String){
        
        let userID = user.uid
        
        let tempRef = databaseRef.child("temperature").child(userID).childByAutoId()
        
        
        
        if temp != "" {
            
            tempRef.setValue(temp)
            
        }
        
    }
    
    
    
    func updateEvents(user: FIRUser, event: String, date:String, hour:String){
        
        let userID = user.uid
        
        let eventRef = databaseRef.child("events").child(userID) //
        
        let keyToBeSet = eventRef.child(date)
        
        let eventToBeSaved = keyToBeSet.child(hour)
        
        
        
        if event != "" {
            
            eventToBeSaved.setValue(event)
            
        }
        
    }
    
    // Mood functions
    
    func updateMood(user: FIRUser, mood: String){
        
        let userID = user.uid
        
        let moodRef = databaseRef.child("moods").child(userID)
        
        // let mainUserID = databaseRef.child("users").child(userID).child(main_uid)
        
        // let moodRef2 = databaseRef.child("moods").child(mainUserID)
        
        //
        
        // do shit
        
        let requestedComponents: Set<Calendar.Component> = [
            
            .year,
            
            .month,
            
            .day
            
        ]
        
        let dateComponents = Calendar.current.dateComponents(requestedComponents, from: currDate)
        
        let day = dateComponents.day?.description
        
        let month = dateComponents.month?.description
        
        let year = dateComponents.year?.description
        
        var finalMoodKey = ""
        
        finalMoodKey += day!
        
        finalMoodKey += month!
        
        finalMoodKey += year!
        
        // finish shit
        
        
        
        let moodToBeSaved = moodRef.child(finalMoodKey)
        
        // let moodToBeSaved2 = moodRef2.child(finalMoodKey)
        
        //let moodToBeSaved = moodRef.childByAutoId()
        
        
        
        if mood != "" {
            
            moodToBeSaved.setValue(mood)
        }
    }
    
    func setMoodRefWithID (moodRefWithID: FIRDatabaseReference){
        //
    }
    
    func setMoodValue(message: String){
        //
    }
        
    
}
