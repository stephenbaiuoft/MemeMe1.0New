//
//  MemeTableViewCell.swift
//  MemeMe1.0
//
//  Created by stephen on 8/10/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    
    func setupCell(meme:Meme){
        memeImage.image = meme.memedImage
        var topText = meme.topText
        topText = editText(text: topText, reverse: false)
        var botText = meme.bottomText
        botText = editText(text: botText, reverse:true)
        memeLabel.text = topText + "..." + botText
        
    }
    
    func editText(text:String, reverse: Bool) -> String{
        if(text.characters.count > 11){
            let i = text.index(text.startIndex, offsetBy: 11)
            if(!reverse){
                return text.substring(to: i )
            }
            else{
                var hold = String(text.characters.reversed())
                hold = hold.substring(to: i)
                hold = String(hold.characters.reversed())
                return hold
            }
        }
        return text
    }
        
}
