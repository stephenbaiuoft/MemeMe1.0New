//
//  MemeModel.swift
//  MemeMe1.0
//
//  Created by stephen on 8/6/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import Foundation
import UIKit

// MARK: Data Structure Definition
extension MemeMainViewController{
    
    struct Meme{
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
    }
}

// MARK: Back-end functions
extension MemeMainViewController{
    
    // Render view to an image
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        
        // y = view.frame.height + self.pickerButton.frame.height
        // so pickerButton goes out of the view
        pickerButton.frame = CGRect(x:0, y:self.view.frame.height + self.pickerButton.frame.height, width:self.view.frame.size.width, height: self.pickerButton.frame.height)
        
        navigationBar.frame = CGRect(x:0, y:self.view.frame.height + self.navigationBar.frame.height,
                                     width: self.view.frame.size.width, height: self.navigationBar.frame.height)
        
        
        let controller = self.navigationController
        controller?.setNavigationBarHidden(true, animated: true)
        controller?.setToolbarHidden(true, animated: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        pickerButton.frame = CGRect(x:0, y:self.view.frame.height - self.pickerButton.frame.height, width:self.view.frame.size.width, height: self.pickerButton.frame.height)
        
        navigationBar.frame = CGRect(x:0, y:self.view.frame.height - self.navigationBar.frame.height,
                                     width: self.view.frame.size.width, height: self.navigationBar.frame.height)
        
        return memedImage
    }
}


// MARK: Delegation Methods
extension MemeMainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: UIImagePickerControllerDelegate Implmentation
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imagePickerView.image = image
            
        }
        // need this or imagePickerView.image = image gives an error
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UINavigationControllerDelegate Implementaion
    
}


// MARK: other necessary UI methods
extension MemeMainViewController{
    
    func keyboardWillShow(_ notification:Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        if (BotTextField.isEditing && view.frame.origin.y == 0){
            
            // shifting upwards, from 0 to keybaord height
            view.frame.origin.y = -keyboardHeight
        }
    }
    
    func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}
