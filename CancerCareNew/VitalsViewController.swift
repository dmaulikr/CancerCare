//
//  VitalsViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class VitalsViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //let currUser = FIRAuth.auth()?.currentUser
    //let networkingService = NetworkingService()
    @IBOutlet weak var addBloodCountButton: UIButton!
    @IBOutlet weak var addTempCountButton: UIButton!

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Sağlık Değerleri"
        self.navigationItem.title = self.navigationController?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBloodButtonAction(_ sender: Any) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bloodPopUp")
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = sender as! UIView
        popController.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        self.present(popController, animated: true, completion: nil)
    }

    @IBAction func addTempButtonAction(_ sender: Any) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tempPopUp")
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = sender as! UIView
        popController.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        self.present(popController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
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
