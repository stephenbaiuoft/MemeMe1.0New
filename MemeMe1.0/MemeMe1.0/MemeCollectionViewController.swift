//
//  MemeCollectionViewController.swift
//  MemeMe1.0
//
//  Created by stephen on 8/11/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {
    // MARK: Variable Seciton
    let gotoMemeMainSegueIdentifier = "collectionToMemeEditorIdentifer"
    let meMeMainVCIdentifer = "MemeMainViewController"
    
    let MemeDetailViewController = "MemeDetailViewController"
    
    var memes:[Meme]!
    var appDelegate: AppDelegate!
    // flowLayout Variables
    let cellSpace:CGFloat = 10.0
    var sectionInsets: UIEdgeInsets!
    let itemsPerRow: CGFloat = 3
    
    // MARK: Outlet Section
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
    // MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        sectionInsets = UIEdgeInsets(top: cellSpace, left: cellSpace, bottom: cellSpace, right: cellSpace)
        flowLayout.sectionInset = sectionInsets
        setCellEqualSpacing(size: view.frame.width, widthHeightRatio: 0.5)
        
        // Load data module
        loadDataModel()
    }
    
    // view Layout will change so auto resize
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        // resize the flowLayout; size.Width is always the transitioned width!
        super.viewWillTransition(to: size, with: coordinator)
        setCellEqualSpacing(size: size.width, widthHeightRatio: size.width/size.height)

    }
    
    // MARK: - Back End Function
    func setCellEqualSpacing(size: CGFloat, widthHeightRatio: CGFloat){
        var dimension:CGFloat = 0.0
        var yNum:CGFloat = 0.0
        // portrait
        if(widthHeightRatio < 1){
            dimension = (size - cellSpace * (itemsPerRow + 2 )) / itemsPerRow
        }
        // lanscape
        else{
            yNum = itemsPerRow * widthHeightRatio
            yNum.round(FloatingPointRoundingRule.down)
            dimension = (size - cellSpace * (yNum + 2)) / yNum
        }
        
        flowLayout.minimumInteritemSpacing = cellSpace
        flowLayout.minimumLineSpacing = cellSpace
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    

    func loadDataModel(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // Go to MemeEditor!!!!!!!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == gotoMemeMainSegueIdentifier){
            let controller = storyboard?.instantiateViewController(withIdentifier: meMeMainVCIdentifer) as! MemeMainViewController
            controller.shouldInitTableVC = false
            present(controller, animated: true, completion: nil)
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard (memes != nil) else{
            return 0
        }
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        // Configure the cell...
        let row = (indexPath as NSIndexPath).row
        cell.MemeImageView.image = memes[row].memedImage
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    // Go to DetailMemeViewController!!!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let controller = storyboard?.instantiateViewController(withIdentifier: MemeDetailViewController ) as! MemeDetailViewController
        let index = (indexPath as NSIndexPath).row
        controller.selectedMeme = memes[index]
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
