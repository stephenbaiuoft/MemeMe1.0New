//
//  SentMemeViewController.swift
//  MemeMe1.0
//
//  Created by stephen on 8/10/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

class SentMemeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Outlet Section
    @IBOutlet weak var memeTableView: UITableView!
    @IBOutlet weak var addMeme: UITabBarItem!
    
    // MARK: Variable Section
    let reuseIdentifier = "memeTableViewCell"
    let memeDetailVCIdentifier = "MemeDetailNavigationController"
    var widthDic = [String:CGFloat]()
    var appDelegate: AppDelegate!
    var memes: [Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTestData()
        // Do any additional setup after loading the view.
        
        initDataModel()
        
        // Init Delegate Methods
        initDelegate()
        //memeTableView.delegate = self
        
                
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoMeme"){
            
        }
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
