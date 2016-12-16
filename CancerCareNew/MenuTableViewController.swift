//
//  MenuTableViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewController: UITableViewController
{
    var pageNames = [String]()
    var identities = [String]()
    
    override func viewDidLoad()
    {
        self.pageNames = ["Ana Sayfa", "Çocuğum", "Planlayıcı", "Sağlık Değerleri", "Hesabım", "İkincil Hesap", "Hakkımızda", "Çıkış Yap"]
        self.identities = ["homePage", "patientPage", "organizerPage", "vitalsPage", "myAccountPage", "secondaryAccountPage", "aboutPage", "logoutPage"]
        
        self.prefersStatusBarHidden
        //self.tableView.backgroundColor = UIColor.lightGray
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.pageNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = self.pageNames[indexPath.row]
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    */
    
}
