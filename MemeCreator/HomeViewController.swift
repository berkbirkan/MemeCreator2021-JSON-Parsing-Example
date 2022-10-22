//
//  HomeViewController.swift
//  MemeCreator
//
//  Created by berk on 13.03.2021.
//

import UIKit
import StoreKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            print(0)
            cell.textLabel?.text = "App Name"
            cell.detailTextLabel?.text = "MemeCreator"
            
        case 1:
            cell.textLabel?.text = "Version"
            cell.detailTextLabel?.text = "0.1"
        case 2:
            cell.textLabel?.text = "Developer"
            cell.detailTextLabel?.text = "Berk Birkan"
            
        case 3:
            cell.textLabel?.text = "Rate"
            cell.detailTextLabel?.text = "Rate Us"
        case 4:
            print(5)
            cell.textLabel?.text = "Make Meme"
            cell.detailTextLabel?.text = "Start to making a meme!"
        default:
            print("1")
            cell.textLabel?.text = "Random Meme"
            cell.detailTextLabel?.text = "Make a random meme"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 3){
            //rate
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                // Fallback on earlier versions
                
            }
        }
        
        if(indexPath.row == 4){
            
            self.performSegue(withIdentifier: "selectmeme", sender: nil)
            
        }
        
        if(indexPath.row == 5){
            self.performSegue(withIdentifier: "randommeme", sender: nil)
        }
        
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
    }
    



}
