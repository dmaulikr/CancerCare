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
    
    
    
    
    
    
    
}
