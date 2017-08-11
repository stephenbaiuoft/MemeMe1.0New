//
//  SentMeme.swift
//  MemeMe1.0
//
//  Created by stephen on 8/10/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import Foundation
import UIKit

// test purpose
func initTestData(){
    let m1 = Meme.init(topText: "t1", bottomText: "b1", originalImage: nil, memedImage: nil)
    let m2 = Meme.init(topText: "t2", bottomText: "b2", originalImage: nil, memedImage: nil)
    let m3 = Meme.init(topText: "t3", bottomText: "b3", originalImage: nil, memedImage: nil)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.memes.append(m1)
    appDelegate.memes.append(m2)
    appDelegate.memes.append(m3)

}

// MARK: TableView Delegate & DataDelegate Methods
extension SentMemeViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logD(msg: "debug blablabla")
        // #warning Incomplete implementation, return the number of rows
        guard (memes != nil) else{
            print("memes in MemeTableVC not instantiated")
            return 0
        }
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MemeTableViewCell
        
        // Configure the cell...
        let row = (indexPath as NSIndexPath).row
        cell.memeImage?.image = memes[row].memedImage
        cell.memeLabel?.text = memes[row].topText + memes[row].bottomText
        return cell
    }
    
    // fix the heightForEach Row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return widthDic[reuseIdentifier]!
    }
    
    // Enabling swip to left to delete a table cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == UITableViewCellEditingStyle.delete){
            let index = (indexPath as NSIndexPath).row
            
            // Note: MUST Remove Data Model First as tableView.deleteRows will UPDATE BY following tableView -> Int (# of cells)
            memes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            // remove the data in memes
        }
    }
    
    // Tell the delegate that a particular row has been selected
    // Need to Present Detailed MemeView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let index = (indexPath as NSIndexPath).row
        let memeNavigationController = self.storyboard?.instantiateViewController(withIdentifier: memeDetailVCIdentifier) as! MemeNavigationViewController
        memeNavigationController.selectedMeme = memes[index]
        
        
    }

}

// MARK: Other Helper Functions Section
extension SentMemeViewController{
    func initDataModel(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        widthDic[reuseIdentifier] = 75.0
    }
    
    func initDelegate(){
        memeTableView.delegate = self
        memeTableView.dataSource = self
        
    }
    
}
