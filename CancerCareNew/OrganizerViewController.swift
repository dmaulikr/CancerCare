//
//  OrganizerViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import EventKit

class OrganizerViewController: UIViewController {
    
    var savedEvent : String = ""

    @IBOutlet weak var eventsToShow: UITextView!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addEventButtonTapped(_ sender: Any) {
        
        var title = eventTextField.text
        var date = datePicker.date
        
        let formatter = DateFormatter()
        formatter.calendar = datePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: date)
        
        savedEvent += title! + ": " + dateString + "\n"
        
        eventsToShow.text = savedEvent
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
