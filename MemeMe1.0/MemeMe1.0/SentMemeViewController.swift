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
    @IBOutlet weak var MemeTableView: UITableView!
    
    // MARK: Variable Section
    let reuseIdentifier = "memeTableViewCell"
    var widthDic = [String:CGFloat]()
    var appDelegate: AppDelegate!
    var memes: [Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTestData()
        // Do any additional setup after loading the view.
       
        
        initDataModel()
        logD(msg: "after loading data")
        
        // Init Delegate Methods
        initDelegate()
        //MemeTableView.delegate = self
        logD(msg: "after assigning MemeTableView.delegate to self already")
                
        
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
