//
//  ViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var colorButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTextFields()
    }
    
    private func setUpTextFields() {
        self.setUpTextField(textField: self.topTextField, text: "TOP")
        self.setUpTextField(textField: self.bottomTextField, text: "BOTTOM")
    }
    
    private func setUpTextField(textField: UITextField, text: String) {
        textField.delegate = self
        textField.defaultTextAttributes = TextAttributes.attribute
        textField.text = text
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Disable camera for Simulators
        super.viewWillAppear(animated)
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotifications()
        if self.memeImageView.image == nil {
            self.activityButton.isEnabled = false
        }else {
            self.activityButton.isEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    
    func generateMemedImage() -> UIImage {
        self.topToolBar.isHidden = true
        self.bottomToolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.topToolBar.isHidden = false
        self.bottomToolBar.isHidden = false
        return memeImage
    }
    
    @IBAction func activityAction(_ sender: UIBarButtonItem) {
        let finalMemeImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [finalMemeImage], applicationActivities: nil)
        let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.memeImageView.image!, memeImage: finalMemeImage)
        
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            if activity?.rawValue != "com.apple.UIKit.activity.SaveToCameraRoll" {
                if success {
                    //Share to social
                    Meme.saveMeme(meme: meme)
                    self.dismiss(animated: true, completion: nil)
                }
            }else {
                //Save to Camera Roll
                Meme.storeToSharedModel(meme)
                let waitingTime = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: waitingTime){
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func fontsAction(_ sender: UIBarButtonItem) {
        let fontPickerConfiguration = UIFontPickerViewController().configuration
        fontPickerConfiguration.includeFaces = true
        let fontPickerVC = UIFontPickerViewController(configuration: fontPickerConfiguration)
        fontPickerVC.delegate = self
        self.present(fontPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func colorAction(_ sender: UIBarButtonItem) {
        let colorActionSheet = UIAlertController(title: "Colors", message: nil, preferredStyle: .actionSheet)
        
        colorActionSheet.addAction(UIAlertAction(title: "Red", style: .default, handler: { (_) in
            self.setTextFieldColor(.red)
        }))
        
        colorActionSheet.addAction(UIAlertAction(title: "Green", style: .default, handler: { (_) in
            self.setTextFieldColor(.green)
        }))
        
        colorActionSheet.addAction(UIAlertAction(title: "Blue", style: .default, handler: { (_) in
            self.setTextFieldColor(.blue)
        }))
        
        colorActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(colorActionSheet, animated: true, completion: nil)
    }
    
    private func setTextFieldColor(_ color: UIColor) {
        self.topTextField.textColor = color
        self.bottomTextField.textColor = color
    }
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
//        self.activityButton.isEnabled = false
//        self.memeImageView.image = UIImage(named: "")
//        self.setUpTextFields()
    }
    
    @IBAction func albumAction(_ sender: UIBarButtonItem) {
        self.present(self.chooseImageFromCameraOrPhoto(.photoLibrary), animated: true, completion: nil)
    }
    
    @IBAction func cameraAction(_ sender: UIBarButtonItem) {
        self.present(self.chooseImageFromCameraOrPhoto(.camera), animated: true, completion: nil)
    }
    
    private func chooseImageFromCameraOrPhoto(_ source: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .fullScreen
        return imagePicker
    }
    
}


extension MemeEditorViewController {
    // MARK: Keyboard Notifications
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboradWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboradWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboradWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboradWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
