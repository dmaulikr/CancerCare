//
//  OrganizerViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import EventKit
import Firebase
import FirebaseAuth


class OrganizerViewController: UIViewController {
    
    var savedEvent : String = ""
    var currEvent : String = ""
    var tempEvent : String = ""
    
    let database = DatabaseAdapter()
    
    let networkingService = NetworkingService()
    
    let databaseRef = FIRDatabase.database().reference()
    
    let currUser = FIRAuth.auth()?.currentUser

    @IBOutlet weak var eventsToShow: UITextView!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addEventButtonTapped(_ sender: Any) {
        
        let title = eventTextField.text
        let date = datePicker.date
        
        let formatter = DateFormatter()
        formatter.calendar = datePicker.calendar
        formatter.dateStyle = .medium
        //formatter.timeStyle = .none // if we want to show the time as well, change .none with something else
        formatter.timeStyle = .short
        let dateString = formatter.string(from: date)
        
        
        let userID = currUser?.uid
        let eventToBeReadRef = databaseRef.child("events").child(userID!)
        
//        eventToBeReadRef.observeSingleEvent(of: .childAdded, with: { (snapshot) in
//            let eventData = snapshot.value // I'm not sure if I really need to hold this but I'll do just in case
//            //var keys = Object.keys(eventData)
//            self.savedEvent = eventData as! String
//            print(eventData as! String)
//        }) { (error) in
//            print(error.localizedDescription)
//        }	
//
        currEvent += title! + ": " + dateString + "\n"
        savedEvent = currEvent + savedEvent
        eventsToShow.text = savedEvent
        
        networkingService.updateEvents(user: currUser!, event: currEvent)
        currEvent = ""
        
        /*
        savedEvent += title! + ": " + dateString + "\n"
        
        eventsToShow.text = savedEvent
        
        let currUser = FIRAuth.auth()?.currentUser
    
        networkingService.updateEvents(user: currUser!, event: savedEvent)
        
        savedEvent = ""
        */

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Planlayıcı"
        self.navigationItem.title = "Planlayıcı"
        
        
        database.fetchDict(key: database.uid!, path: "events/"){
            result in
            self.eventsToShow.text = ""
            for r in result{
                self.savedEvent += (r.value as! String) + "\n"
            }
            self.eventsToShow.text = self.savedEvent
        }

        
        // Do any additional setup after loading the view.
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
