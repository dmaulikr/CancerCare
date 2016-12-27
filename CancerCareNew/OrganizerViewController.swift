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

class OrganizerViewController: UIViewController, UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var savedEvent : String = ""
    
    var currEvent : String = ""
    let database = DatabaseAdapter()
    let networkingService = NetworkingService()

    let databaseRef = FIRDatabase.database().reference()

    let currUser = FIRAuth.auth()?.currentUser
    
    @IBOutlet weak var eventLocationTextField: UITextField!
       
    
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
        //eventsToShow.text = savedEvent
        
            networkingService.updateEvents(user: currUser!, year: yearString, month: monthString, day: dayString, title: title!, place: place!, hour: finalHourString)
        
        currEvent = ""
        var alertMessage = ""
            if appDelegate.eventStore == nil {
                
                appDelegate.eventStore = EKEventStore()
                
                appDelegate.eventStore?.requestAccess(
                    
                    to: EKEntityType.reminder, completion: {(granted, error) in
                        
                        if !granted {
                            
                            print("Access to store not granted")
                            
                            print(error?.localizedDescription)
                            
                        } else {
                            
                            print("Access granted")
                            
                        }
                        
                })
                
            }
            
            if (appDelegate.eventStore != nil) {
                
                alertMessage = self.createReminder()
                
            }
            displayMessage(alertMessage: alertMessage)
            
    }
    
    func createReminder() -> String{
        
        var result = ""
        
        let reminder = EKReminder(eventStore: appDelegate.eventStore!)
        
        reminder.title = eventTextField.text!
        
        reminder.calendar = appDelegate.eventStore!.defaultCalendarForNewReminders()
        
        let date = datePicker.date
        
        let alarm = EKAlarm(absoluteDate: date)
        
        reminder.addAlarm(alarm)
        
        do {
            
            try appDelegate.eventStore?.save(reminder, commit: true)
            
            result = "Hatırlatıcı oluşturuldu"
            
        } catch let error {
            
            result = "Hata! Tekrar deneyiniz"//print("Reminder failed with error \(error.localizedDescription)")
            
        }
        
        return result
        
    }
    
    
    
    func displayMessage(alertMessage: String) {
        
        let alertController = UIAlertController(title: "", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default)
            
        {
            
            (UIAlertAction) -> Void in
            
        }
        
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true)
            
        {
            
            () ->  Void in
            
        }
        
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
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
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
    
    /*
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDist: -150, up:true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDist: -150, up:false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(textField: UITextField, moveDist: Int, up:Bool){
        let moveDuration = 0.3
        let movement : CGFloat = CGFloat (up ? moveDist: -moveDist)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventTextField.endEditing(true)
        eventLocationTextField.endEditing(true)
    }*/
}
