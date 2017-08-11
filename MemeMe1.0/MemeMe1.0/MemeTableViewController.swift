//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by stephen on 8/11/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    // MARK: Outlet Section
    
    
    // MARK: Variable Section
    let reuseIdentifier = "memeTableViewCell"
    let gotoMemeEditor = "gotoMemeEditor"
    let memeEditorController = "MemeMainViewController"
    let MemeDetailViewController = "MemeDetailViewController"
    
    
    var widthDic = [String:CGFloat]()
    var appDelegate: AppDelegate!
    var memes: [Meme]!
    
    // MARK: Function
    override func viewDidLoad() {
        super.viewDidLoad()

        initTestData()
        // Do any additional setup after loading the view.
        logD(msg: "loading data in viewDidLoad")
        loadDataModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logD(msg: "loading data in viewWillAppear")
        loadDataModel()
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard (memes != nil) else{
            return 0
        }
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MemeTableViewCell
        
        // Configure the cell...
        let row = (indexPath as NSIndexPath).row
        cell.memeImage?.image = memes[row].memedImage
        cell.memeLabel?.text = memes[row].topText + memes[row].bottomText
        return cell
    }
    
    // fix the heightForEach Row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return widthDic[reuseIdentifier]!
    }
    
    // Enabling swip to left to delete a table cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == UITableViewCellEditingStyle.delete){
            let index = (indexPath as NSIndexPath).row
            
            // Note: MUST Remove Data Model First as tableView.deleteRows will UPDATE BY following tableView -> Int (# of cells)
            memes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            // remove the data in memes
        }
    }
    
    // Tell the delegate that a particular row has been selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let controller = storyboard?.instantiateViewController(withIdentifier: MemeDetailViewController ) as! MemeDetailViewController
        let index = (indexPath as NSIndexPath).row
        controller.selectedMeme = memes[index]
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == gotoMemeEditor){
            let controller = storyboard?.instantiateViewController(withIdentifier: memeEditorController) as! MemeMainViewController
            controller.shouldInitTableVC = false
            present(controller, animated: true, completion: nil)
        }
    }
    
}
