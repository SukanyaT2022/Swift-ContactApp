//
//  CreateContactViewController.swift
//  contact-app
//
//  Created by Tiparpron Sukanya on 10/3/23.
//

import Foundation
import UIKit
import CoreData
import AVFoundation
class CreateContactViewController : UIViewController{
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var contactImageButton: UIButton!
    
    var isViewOnly = false
    var contactData : Contact?
    var imagePath = "" //open camera from gallery
    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewOnly == true{
            displayData()
        }
    }
    func displayData(){
        if let name = contactData?.name{
           let component = name.components(separatedBy: " ")
            firstNameTextField.text = component.first
            lastNameTextField.text = component.last
        }
        emailTextField.text = contactData?.email
        phoneNumberTextField.text = contactData?.phone
        if let imagePath = contactData?.imagePath, let image = UIImage(contentsOfFile: imagePath){
           
            contactImageView.image = image
        }else{
            contactImageView.image = UIImage(systemName: "person")
        }
        firstNameTextField.isUserInteractionEnabled = false
        lastNameTextField.isUserInteractionEnabled = false
        //above just show but it can not edit- view only - not allow edit we put false
        emailTextField.isUserInteractionEnabled = false
        phoneNumberTextField.isUserInteractionEnabled = false
        contactImageButton.isUserInteractionEnabled = false
        saveButton.setTitle("Mark Favourite", for: .normal)
        
    }
    
    //action below line
    
    @IBAction func SaveButtonAction(_ sender: Any) {
        createNewContact()
    }
    
    @IBAction func contactImageButtonAction(_ sender: Any) {
        checkPermission()
    }
    
    func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for:.video){
        case .authorized:
            DispatchQueue.main.async {
                self.openMedia()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for:.video) { status in
                if status == true{
                    DispatchQueue.main.async {
                        self.openMedia()
                    }
                }
            }
        default:
            print("Condition deny")
            
        }
    }
    func openMedia(){
        //picker :  get image for user after user decide and click
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        //below is alert to user if what option they want camera or gallery
        let alertController = UIAlertController(title: "Choose", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController,animated: true,completion: nil)
            }
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController,animated: true,completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true)
        
    }
    func saveImage()->String{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = documentDirectory.appendingPathComponent(phoneNumberTextField.text ?? "unknown")
        if let data = contactImageView.image?.jpegData(compressionQuality: 0.5),
           !FileManager.default.fileExists(atPath: fileUrl.path){
            try? data.write(to: fileUrl)
            return fileUrl.path
        }
        return ""
    }
    
    
    func createNewContact(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let description = NSEntityDescription.entity(forEntityName: "Contact", in: context)
            let contactEntity = NSManagedObject(entity: description!, insertInto: context) as? Contact
            contactEntity?.name = "\(firstNameTextField.text ?? "") \(lastNameTextField.text ?? "")"
            contactEntity?.phone = phoneNumberTextField.text ?? ""
            contactEntity?.email = emailTextField.text ?? ""
//            ?? "" for not show option on the screen
            contactEntity?.imagePath = saveImage()
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}

extension CreateContactViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true){
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            DispatchQueue.main.async {
                self.contactImageView.image = image
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true)
    }
}
