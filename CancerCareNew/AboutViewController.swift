//
//  AboutViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var homePageLinkButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.title = "Hakkımızda"
        self.navigationItem.title = self.navigationController?.title
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toHomePageLink(_ sender: UIButton) {
        //http://www.kacuv.org/
        if let url = NSURL(string: "http://www.kacuv.org/") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func toDonateLink(_ sender: UIButton) {
        //https://bagis.kacuv.org/#/
        if let url = NSURL(string: "https://bagis.kacuv.org/#/") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func toContactLink(_ sender: UIButton) {
        //http://www.kacuv.org/iletisim/
        if let url = NSURL(string: "http://www.kacuv.org/iletisim/") {
            UIApplication.shared.openURL(url as URL)
        }
    }

    
    /*
 @IBAction func toHomePageLink(_ sender: UIButton) {
 
 // http://www.kacuv.org/
 
 if let url = NSURL(string: "http://www.kacuv.org/") {
 
 UIApplication.shared.openURL(url as URL)
 
 }
 
 }
 */
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
