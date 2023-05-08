import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    let sourceType: UIImagePickerController.SourceType
    let completionHandler: (UIImage?) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No implementation needed here
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let completionHandler: (UIImage?) -> Void
        
        init(completionHandler: @escaping (UIImage?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completionHandler(nil)
            picker.dismiss(animated: true, completion: nil)
        }
    }
}



struct ContentView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State var UserUUID : String?
    @StateObject private var betaface = BetaFace()

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable() 
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            } else { 
                Text("No image selected")
            }

            // Button to select an image
            Button(action: {
                isShowingImagePicker = true
            }) {
                Text("Select Image")
            }
            .padding()
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    selectedImage = image
                    isShowingImagePicker = false
                }
            }

            // Button to upload the selected image
            Button(action: {
                uploadImage()
                 
            }) {
                Text("Upload Image")
                Text(UserUUID ?? "Nothing Yet!")
            }
            .padding()
        }
    }
    
    
    private func uploadImage() {
        guard let selectedImage = selectedImage else {
            return
        }

        let temporaryDirectory = FileManager.default.temporaryDirectory
        let imageURL = temporaryDirectory.appendingPathComponent("selectedImage.jpg")

        if let imageData = selectedImage.jpegData(compressionQuality: 1.0) {
            // Write the data to the temporary file
            do {
                try imageData.write(to: imageURL)
            } catch {
                print("Error saving image to file")
                return
            }

            betaface.getData(callback: {
                print("User UUID = " + (betaface.UUUID ?? "nothing"))
                UserUUID = betaface.UUUID
            }, selectedImageURL: imageURL)
        }
 else {
            print("Error converting image to data")
        }
    }
}
