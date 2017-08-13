//
//  SentMeme.swift
//  MemeMe1.0
//
//  Created by stephen on 8/10/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import Foundation
import UIKit

// MARK: Other Helper Functions Section
extension MemeTableViewController{
    
    func loadDataModel(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        widthDic[reuseIdentifier] = 130
    }
    
    
}
