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
        let childRef = databaseRef.child("children").child(userID)
        let timeStamp = childRef.child("timestamp")
        if rbc != "" {
            timeStamp.child("rbc").setValue(rbc)
        }
        if wbc != "" {
            timeStamp.child("wbc").setValue(wbc)
        }
        if anc != "" {
            timeStamp.child("anc").setValue(anc)
        }
       
        
        
    }
    func updateChildTemp(user: FIRUser, temp: String){
        let userID = user.uid
        let childRef = databaseRef.child("children").child(userID)
        let timeStamp = childRef.child("timestamp")

        if temp != "" {
            timeStamp.child("temp").setValue(temp)
        }
    }
    
    
    
    
    
    
    
}
