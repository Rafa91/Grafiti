//
//  GraffitiDetailsViewController.swift
//  Graffiti
//
//  Created by Rafael Navarro on 23/3/17.
//  Copyright © 2017 Rafael Navarro. All rights reserved.
//

import UIKit

protocol GraffitiDetailsViewControllerDelegate: class {
    func graffitiDidFinishGetTagged(sender: GraffitiDetailsViewController, taggedGraffiti: Graffiti)
}

class GraffitiDetailsViewController: UIViewController {
    
    weak var delegate: GraffitiDetailsViewControllerDelegate?

    @IBOutlet weak var imgGraffiti: UIImageView!
    @IBOutlet weak var longitudLable: UILabel!
    @IBOutlet weak var latitudLabel: UILabel!
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var taggedGraffiti : Graffiti?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = #imageLiteral(resourceName: "img_navbar_title")
        self.navigationItem.titleView = UIImageView(image: image)
        
        let takePictureGesture = UITapGestureRecognizer(target: self, action: #selector(takePictureTapped))
        self.imgGraffiti.addGestureRecognizer(takePictureGesture)
        
        configureLabels()
        
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func configureLabels(){
        latitudLabel.text = String(format: "%.8f", (taggedGraffiti?.coordinate.latitude)!)
        longitudLable.text = String(format: "%.8f", (taggedGraffiti?.coordinate.longitude)!)
        direccionLabel.text = taggedGraffiti?.graffitiAdress
    }
    @IBAction func saveGraffiti(_ sender: Any) {
        if let image = imgGraffiti.image{
            let randomName = UUID().uuidString.appending(".png")
            if let url = GraffitiManager.sharedInstance.imagesURL()?.appendingPathComponent(randomName),
                let imageData = UIImagePNGRepresentation(image){
                do {
                    try imageData.write(to: url)
                } catch (let error){
                    print("error salvando imagen: \(error)")
                }
            }
            taggedGraffiti = Graffiti(address: direccionLabel.text!, latitude: Double(latitudLabel.text!)!, longitude: Double(longitudLable.text!)!, image: randomName)
            
            if let taggedGraffiti = taggedGraffiti{
                delegate?.graffitiDidFinishGetTagged(sender: self, taggedGraffiti: taggedGraffiti)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension GraffitiDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func takePictureTapped(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            showPhotoMenu()
        }else{
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "Sacar foto", style: .default) { _ in
            self.takePhotoWithCamera()
        }
        
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: "Elegir foto de la librería", style: .default) { _ in
            self.choosePhotoFromLibrary()
        }
        alertController.addAction(chooseFromLibraryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary(){
        let imagePicer = UIImagePickerController()
        imagePicer.sourceType = .photoLibrary
        imagePicer.delegate = self
        imagePicer.allowsEditing = true
        present(imagePicer, animated: true, completion: nil)
    }
    
    func takePhotoWithCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageTaken = info[UIImagePickerControllerEditedImage] as? UIImage
        imgGraffiti.image = imageTaken
        saveButton.isEnabled = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}











