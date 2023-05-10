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
    @StateObject var betaface = BetaFace()
    @StateObject var recognize = Recognize()
    @StateObject var recognizeUUID = RecognizeUUID()
    @StateObject var transform = Transform()
    @State var base64String = "base64-encoded-image-string"
    @State var matchUUID = ""
    @State var recognizeUUIDStringThing = ""
    
    let backgroundGradient = LinearGradient(
        colors: [Color.G1, Color.G1],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
  NavigationView{
        ZStack{
            backgroundGradient
            VStack {

                
                //uploaded image
                if let image = selectedImage {
                    VStack{
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 200.0, height: 200.0)
                            .aspectRatio(image.size, contentMode: .fill)
                            .border(Color.black, width: 2)
                        Text("↑ Selected Image ↑").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                    }
                } else {
                    Text("No image selected").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                }

                // Button to select an image
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    
                    Image(systemName: "photo.on.rectangle.angled").foregroundColor(Color.red) .font(Font.system(size: 25, weight: .semibold))
                    Text("Upload Image").font(Font.system(size: 20, weight: .bold))
                }
                .padding()
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        selectedImage = image
                        isShowingImagePicker = false
                    }
                }.background(Color.black
                ).clipShape(Capsule()).foregroundColor(.G3)

                // Upload/Search Button

                Button(action : {
                   uploadImage()
                }, label: {
                    
                    NavigationLink(destination : SearchInfo(base64String: $base64String).onAppear(){uploadImage()}){

                        Image(systemName: "magnifyingglass").foregroundColor(Color.red) .font(Font.system(size: 25, weight: .semibold))
                        Text("Search").font(Font.system(size: 20, weight: .bold))

                    }
                }).padding().background(Color.black
                ).clipShape(Capsule()).foregroundColor(.G3)


//                // Button to upload the selected image
//                Button(action: {
//                    uploadImage()
//
//                }) {
//                    Text("Upload Image")
//                    Text(UserUUID ?? "Nothing Yet!")
//                }
//                .padding()

                // Recodnize image - search against database
                
//                Button(action: {
//                    print(UserUUID! )
//                    recognize.getData2(callback: {
//                        recognizeUUIDStringThing = recognize.recognizeUUID
//                    }, faceUUID: UserUUID!)
//                }) {
//                    Text(" Recognize")
//                    Text(recognizeUUIDStringThing)
//                }
//                .padding()
                
                // Recognize UUID Button
//                Button(action: {
//                    recognizeUUID.getData(callback: {
//                        matchUUID = recognizeUUID.match
//                        print("matchUUID + " + matchUUID)
//                    }, recognizeUUIDString: recognizeUUIDStringThing)
//                }) {
//                    Text(" RecognizeUUID")
//                    Text(matchUUID)
//                }
//                .padding()
                
                // Transform Button
//                Button(action:{
//                    transform.getData3(callback: {
//                        base64String = transform.imageBase64
//                    }, faceUUID: matchUUID)
//                }) {
//                    Text("Transform")
//                }


            }.ignoresSafeArea()
        }.ignoresSafeArea()
        }.navigationViewStyle(StackNavigationViewStyle())
 
        
        
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
                // recognize
                recognize.getData2(callback: {
                    recognizeUUIDStringThing = recognize.recognizeUUID
                // recognizeUUID
                    recognizeUUID.getData(callback: {
                        matchUUID = recognizeUUID.match
                        print("matchUUID + " + matchUUID)
                        
                        // transform
                            transform.getData3(callback: {
                                base64String = transform.imageBase64
                            }, faceUUID: matchUUID)
                    }, recognizeUUIDString: recognizeUUIDStringThing)
                }, faceUUID: UserUUID!)
            }, selectedImageURL: imageURL)
        }
 else {
            print("Error converting image to data")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}


