//
//  SeminarStore.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import Foundation
import SwiftUI

class SeminarStore: ObservableObject {
    @Published var seminarStore: [Seminar] = []
    
    func setLocation(latitude: Double, longitude: Double, address: String) -> SeminarLocation {
        let location = SeminarLocation(latitude: latitude, longitude: longitude, address: address)
        return location
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            picker.dismiss(animated: true)
        }
    }
}
