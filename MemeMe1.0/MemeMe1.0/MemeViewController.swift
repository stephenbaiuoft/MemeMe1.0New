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
        // MARK: AppDelegate Class Set Up for Meme App
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        if(memes.count > 0 ){
            // hand over to TabView VC
            initTabViewVC()
        }
        
        pickerController = UIImagePickerController()
        // pickerController notifies MemeMainVC then things happen, using MemeMainVC custom/default func
        pickerController.delegate = self
        
        // set-up for UITextFields
        initTextFieldAttribute(textField: topTextField, defaultString: "TOP")
        initTextFieldAttribute(textField: botTextField, defaultString: "BOT")
        
        // Mark: Initialize Delegates
        initDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        shareItem.isEnabled = (imagePickerView?.image != nil)                
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }


    // MARK: Outlet Declaration
    @IBOutlet weak var imagePickerView: UIImageView!

    @IBOutlet weak var pickerButton: UIToolbar!
    @IBOutlet weak var cameraItem: UIBarButtonItem!
    @IBOutlet weak var albumItem: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var botTextField: UITextField!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareItem: UIBarButtonItem!
    @IBOutlet weak var cancelItem: UIBarButtonItem!
    @IBOutlet weak var outerStackView: UIStackView!
    
    
    var pickerController: UIImagePickerController!
    var memedImage: UIImage? = nil
    var appDelegate: AppDelegate!
    var memes:[Meme]!
    
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
    func initTextFieldAttribute(textField: UITextField, defaultString: String){
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
        textField.text = defaultString
        
    }
    
    
    func initDelegates(){
        prepareTextField(textField: topTextField)
        prepareTextField(textField: botTextField)
    }
    
    
    func prepareTextField(textField: UITextField){
        textField.delegate = TextFieldDelegate
    }
    
    
    // share the edited Meme UIImage
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        
        let activityC = UIActivityViewController.init(activityItems: [memedImage ?? UIImage()], applicationActivities: [])
        present(activityC, animated: true, completion: nil)
        
        //UIActivityType?, Bool, [Any]?, Error?
        
        
        activityC.completionWithItemsHandler = {
            (activity: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError:Error?) -> Void in
            if (completed){
                self.save()
                // dimiss the activity view
                activityC.dismiss(animated: true, completion: nil)
                // go to TabViewVC now
                self.initTabViewVC()
            }
        }
    }

    
    // removes the selected picture
    @IBAction func cancelMeme(){
        imagePickerView.image = nil
        topTextField.text = "TOP"
        botTextField.text = "BOT"
        
        // dimiss keyboard if necessary
        topTextField.resignFirstResponder()
        botTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    // save mem Object
    func save() {
        // Create the meme
        if(memedImage != nil){
            let meme = Meme(topText: topTextField.text!, bottomText: botTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage!)
            
        //  Save to the app delegate's meems array 
        //  wonder if reloading from UIApplication.shared.delegate is necessary here?
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.append(meme)
        
        }
    }
}

