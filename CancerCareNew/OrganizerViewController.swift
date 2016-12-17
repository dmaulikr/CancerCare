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
    let database = DatabaseAdapter()
    let networkingService = NetworkingService()

    let databaseRef = FIRDatabase.database().reference()

    let currUser = FIRAuth.auth()?.currentUser
    
    @IBOutlet weak var eventLocationTextField: UITextField!
       
    @IBOutlet weak var eventsToShow: UITextView!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    func getEventDate() -> String {
    let currentDateTime = Date()

    //let title = eventTextField.text
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    let dayString = formatter.string(from: datePicker.date)
    formatter.dateFormat = "MM"
    let monthString = formatter.string(from: datePicker.date)
    formatter.dateFormat = "yyyy"
    let yearString = formatter.string(from: datePicker.date)
    let dateString = dayString + monthString + yearString
    return dateString
    }
    
    
        @IBAction func addEventButtonTapped(_ sender: Any)  {
        let title = eventTextField.text
        let place = eventLocationTextField.text
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let dayString = formatter.string(from: datePicker.date)
        formatter.dateFormat = "MM"
        let monthString = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy"
        let yearString = formatter.string(from: datePicker.date)
        let dateString = dayString + monthString + yearString
        let calendar = datePicker.calendar
        let hour = calendar?.component(.hour, from: datePicker.date)
        let minute = calendar?.component(.minute, from: datePicker.date)
        let hourString = hour!.description
        let minuteString = minute!.description
        let finalHourString = hourString + minuteString
        
        currEvent += title!// + ": " + dateString + finalHourString
        savedEvent = currEvent + "\n" + savedEvent
        eventsToShow.text = savedEvent
        
            networkingService.updateEvents(user: currUser!, year: yearString, month: monthString, day: dayString, title: title!, place: place!, hour: finalHourString)
        
        currEvent = ""
    }
    
    func getCurrentDate() -> String{
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
        dateKey += year!
        dateKey += month!
        dateKey += day!
        return dateKey
    }
    
    func displayAllEvents(completion: @escaping (String)-> Void) {
        let currDateKey = getCurrentDate()
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        var result = ""
        
        database.fetchDict(key: "\(currUserID!)", path: "events/"){ resultt in
            for k in resultt {
                if (k.key == currDateKey){
                    result = "Bugünkü etkinik: \(k.value)"
                }
            }
            completion(result)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Planlayıcı"
        self.navigationItem.title = "Planlayıcı"
        
        /*database.fetchDict(key: database.uid!, path: "events/"){
         result in
         self.eventsToShow.text = ""
         for r in result{
         self.savedEvent += (r.value as! String) + "\n"
         }
         self.eventsToShow.text = self.savedEvent
         }
         */
        // Do any additional setup after loading the view.
    }
}
