//
//  DetailedMemeNavigationController.swift
//  MemeMe1.0
//
//  Created by stephen on 8/11/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    // MARK: Class Variables
    var selectedMeme: Meme!
    let memeEditorController = "MemeMainViewController"
    let gotoMemeEditorSegueIdentifier = "detailMemeToMemeMain"

    
    // MARK: IBOutlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        let item = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(gotoMemeEditor))
        self.navigationItem.setRightBarButtonItems([item], animated: false)
        memeImageView.image = selectedMeme.memedImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func gotoMemeEditor(){
        let controller = storyboard?.instantiateViewController(withIdentifier: memeEditorController) as! MemeMainViewController        
        controller.editMode = true
        controller.editMeme = selectedMeme
        
        present(controller, animated: true, completion: nil)
        
    }
    
}
