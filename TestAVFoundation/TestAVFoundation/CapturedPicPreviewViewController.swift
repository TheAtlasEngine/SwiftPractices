//
//  CapturedPicPreviewViewController.swift
//  TestAVFoundation
//
//  Created by Kosuke Nishimura on 2019/05/19.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

class CapturedPicPreviewViewController: UIViewController {

    @IBOutlet weak var previewView: UIImageView!
    static let storyboardIdentifier = "CapturedPicPreviewViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.previewView.contentMode = .scaleAspectFill
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        savePicToLibrary()
    }
    @IBAction func retakeButtonTapped(_ sender: Any) {
        backToCameraView()
    }
    @IBAction func albumButtonTapped(_ sender: Any) {
        showAlbum()
    }
    
    private func savePicToLibrary() {
        guard let image = self.previewView.image else {
            fatalError("previewView.image is nil")
        }
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        
        let alert = UIAlertController(title: "Saved to the library", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func backToCameraView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Cannot open Photo Library", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension CapturedPicPreviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Error: info[UIImagePickerController.InfoKey.originalImage] Failure")
        }
        
        let imageDetailVC = ImageDetailViewController()
        _ = imageDetailVC.view
        imageDetailVC.imageDetailView.image = image
        picker.pushViewController(imageDetailVC, animated: true)
    }
    
}
