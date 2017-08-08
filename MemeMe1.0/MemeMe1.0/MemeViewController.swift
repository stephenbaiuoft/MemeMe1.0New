//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by stephen on 8/1/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

class MemeMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        // set-up for UITextFields
        initTextFieldAttribute(textField: TopTextField)
        initTextFieldAttribute(textField: BotTextField)
        
        // Mark: Initialize Delegates
        initDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotifications()
        shareItem.isEnabled = (imagePickerView?.image != nil)                
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }


    // MARK: Outlet Declaration
    @IBOutlet weak var imagePickerView: UIImageView!

    @IBOutlet weak var pickerButton: UIToolbar!
    @IBOutlet weak var cameraItem: UIBarButtonItem!
    @IBOutlet weak var albumItem: UIBarButtonItem!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BotTextField: UITextField!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareItem: UIBarButtonItem!
    @IBOutlet weak var cancelItem: UIBarButtonItem!
    @IBOutlet weak var outerStackView: UIStackView!
    
    
    var pickerController: UIImagePickerController!
    var memedImage: UIImage? = nil
    
    let TextFieldDelegate = DisplayUITextFieldDelegate()
    
    // MARK: function deClaration
    // pick an image from UI
    @IBAction func pickAnImageFromAlbum(){
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    
    // initializes Top/Bot Text Fields
    func initTextFieldAttribute(textField: UITextField){
        // In a stack view, textAlignment has no effect
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name:"Helvetica Neue", size: 40) ??  UIFont.init(),
            NSStrokeWidthAttributeName: -5.0,
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        // working textField Attributes here!!
        textField.textAlignment = .center
        
    }
    
    
    func initDelegates(){
        prepareTextField(textField: TopTextField)
        prepareTextField(textField: BotTextField)
    }
    
    func prepareTextField(textField: UITextField){
        textField.delegate = TextFieldDelegate
    }
    
    // share the edited Meme UIImage
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        
        let activityC = UIActivityViewController.init(activityItems: [memedImage ?? UIImage()], applicationActivities: [])
        self.present(activityC, animated: true, completion: nil)
        
        //UIActivityType?, Bool, [Any]?, Error?
        
        
        activityC.completionWithItemsHandler = {
            (activity: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError:Error?) -> Void in
            if (completed){
                self.save()
                
                // dimiss the activity view
                activityC.dismiss(animated: true, completion: nil)
                
                // re-draw
                self.outerStackView.setNeedsLayout()
                    print("outerStackView update")
            }
        }
        
    
    }

    
    // removes the selected picture
    @IBAction func cancelMeme(){
        imagePickerView.image = nil
        TopTextField.text = ""
        BotTextField.text = ""
        dismiss(animated: true, completion: nil)
        
        // dimiss keyboard if necessary
        TopTextField.resignFirstResponder()
        BotTextField.resignFirstResponder()
    }
    
    // save mem Object
    func save() {
        // Create the meme
        if(memedImage != nil){
            let meme = Meme(topText: TopTextField.text!, bottomText: BotTextField.text!, originalImage: imagePickerView.image!, memedImage: self.memedImage!)
        }
        
        // to be saved to album
    }
}

