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
    
    private func saveInfo(user: FIRUser!, name: String, surname: String, email: String, password: String){
        //create user info
        let userInfo = ["email": user.email, "name": name, "surname": surname, "password": password, "uid": user.uid]
        
        //create user reference
        let userRef = databaseRef.child("users").child(user.uid)
        
        //Save the user info in the database
        userRef.setValue(userInfo)
        
        signIn(email: user.email!, password: password)
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
    
    func updateEvents(user: FIRUser, event: String){
        let userID = user.uid
        let eventRef = databaseRef.child("events").child(userID) // this will keep all events of the user in the same place. we may or may not want to use this because I cannot anticipate whether this is the better solution
        let eventToBeSaved = eventRef.childByAutoId()
        
        if event != "" {
            eventToBeSaved.setValue(event)
        }
        
        /*
        let childRef = databaseRef.child("children").child(userID)
        let events = childRef.child("events")
        if event != "" {
            events.child("event").setValue(event)
        }
        */
    }
    
    func updateMood(user: FIRUser, mood: String){
        let userID = user.uid
        let moodRef = databaseRef.child("moods").child(userID)
        let moodToBeSaved = moodRef.childByAutoId()
        
        if mood != "" {
            moodToBeSaved.setValue(mood)
        }
    }
    
  
    
    
    
    
    
    
}
