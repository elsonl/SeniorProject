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
    @State private var isShowingCameraPicker = false
    @State private var isShowingLibraryPicker = false
    @State var selectedImage: UIImage?
    @State var UserUUID : String?
    @StateObject var betaface = BetaFace()
    @StateObject var recognize = Recognize()
    @StateObject var recognizeUUID = RecognizeUUID()
    @StateObject var transform = Transform()
    @State var base64StringsArray : [String] = []
    @State var base64Strings : String = ""
    @State var matchUUID = ""
    @State var recognizeUUIDStringThing = ""
    @State var confidenceLevel = 0.0
    @State var confidencePercentArray: [Double] = []
    @State var matchUUIDArray: [String] = []
    @State var indiciesCount : Int = 0
    @State var personIDArrayThing : [String] = []
    @State var finish : Bool = false
    let backgroundGradient = LinearGradient(
        colors: [Color.B1, Color.B1],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
  NavigationView{
        ZStack{
            backgroundGradient
            VStack {
                Image("FinderOfFame").resizable().frame(width: 400, height: 75)
//                Image("FinderFame").resizable().background(Color.B1).clipShape(Circle()).shadow(color: Color.Orangish, radius: 10).overlay(Circle().stroke(Color.Orangish,lineWidth: 3)).frame(width: 175, height: 175).scaledToFit ().frame(alignment: .top).padding()
                
                //uploaded image
                if let image = selectedImage {
                    VStack{
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 150, height: 200)
                            .aspectRatio(image.size, contentMode: .fit)
//                            .border(Color.black, width: 2)
                        Text("↑ Selected Image ↑").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                    }
                } else {
                     VStack{
                        Image("FameFinder")
                            .resizable()
                            .frame(width: 150, height: 200)
                            .aspectRatio(contentMode: .fit)
//                            .border(Color.black, width: 2)
                            .opacity(0.0)
                        Text("No image selected").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                    }
                }

                
                // Button to take a picture
                VStack{
                    Button(action: {
                        isShowingCameraPicker = true
                        base64StringsArray.removeAll()
                        confidencePercentArray.removeAll()
                        matchUUIDArray.removeAll()
                        transform.transformBool = true
                        personIDArrayThing.removeAll()
                        finish = false
                    }) {
                        Image(systemName: "camera").foregroundColor(Color.red).font(Font.system(size: 25, weight: .semibold))
                        Text("Take Photo").font(Font.system(size: 20, weight: .bold))
                    }
                    .padding()
                    .sheet(isPresented: $isShowingCameraPicker) {
                        ImagePicker(sourceType: .camera) { image in
                            selectedImage = image
                            isShowingCameraPicker = false
                            base64StringsArray.append("nothign yet")
                            confidencePercentArray.append(0.00)
                            indiciesCount = 0
                            personIDArrayThing.append("nothing yet")
                        }
                    }
                    .background(Color.black)
                    .clipShape(Capsule())
                    .foregroundColor(.G3)
                    // button to select image
                    Button(action: {
                        isShowingLibraryPicker = true
                        base64StringsArray.removeAll()
                        confidencePercentArray.removeAll()
                        matchUUIDArray.removeAll()
                        transform.transformBool = true
                        personIDArrayThing.removeAll()
                        finish = false
                        
                    }) {
                        
                        Image(systemName: "photo.on.rectangle.angled").foregroundColor(Color.red) .font(Font.system(size: 25, weight: .semibold))
                        Text("Upload Image").font(Font.system(size: 20, weight: .bold))
                    }
                    .padding()
                    .sheet(isPresented: $isShowingLibraryPicker) {
                        ImagePicker(sourceType: .photoLibrary) { image in
                            selectedImage = image
                            isShowingLibraryPicker = false
                            
                            base64StringsArray.append("nothign yet")
                            confidencePercentArray.append(0.00)
                            indiciesCount = 0
                            personIDArrayThing.append("nothing yet")
                        }
                    }.background(Color.black
                    ).clipShape(Capsule()).foregroundColor(.G3)
                }

                
                // Upload/Search Button
                Button(action : {

                }, label: {
                    
                    NavigationLink(destination : SearchInfo(base64StringsArray: $base64StringsArray, confidenceLevel: $confidenceLevel, selectedImage: $selectedImage, base64Strings: $base64Strings, indiciesCount: $indiciesCount, personIDArrayThing: $personIDArrayThing, confidencePercentArray: $confidencePercentArray, finish: $finish).onAppear{
                        uploadImage(selectedImage: selectedImage)
                        
                    }){

                        Image(systemName: "magnifyingglass").foregroundColor(Color.red) .font(Font.system(size: 25, weight: .semibold))
                        Text("Search").font(Font.system(size: 20, weight: .bold))

                    }
                }).padding().background(Color.black
                ).clipShape(Capsule()).foregroundColor(.G3)


 }.ignoresSafeArea()
        }.ignoresSafeArea()
        }.navigationViewStyle(StackNavigationViewStyle())
 
        
        
    }
    
    private func uploadImage(selectedImage: UIImage?) {
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
//                print("User UUID = " + (betaface.UUUID ?? "nothing"))
                UserUUID = betaface.UUUID
                // recognize
                recognize.getData2(callback: {
                    recognizeUUIDStringThing = recognize.recognizeUUID
//                 recognizeUUID
                    recognizeUUID.getData(callback: {
                        matchUUID = recognizeUUID.match
//                        print("matchUUID + " + matchUUID)
                        confidenceLevel = recognizeUUID.confidence
                        
                        confidencePercentArray = recognizeUUID.confidenceArray
                        matchUUIDArray = recognizeUUID.matchArray
                        personIDArrayThing = recognizeUUID.personIDArray
                        for i in personIDArrayThing.indices{
                           
                                let components = personIDArrayThing[i].components(separatedBy: "@")
                                let name = components.first?.trimmingCharacters(in: .whitespaces)
                                print(name)
                                personIDArrayThing[i] = name!
                                
                            
                        }
                        indiciesCount = recognizeUUID.indicies
//                        print("INDICIES")
//                        print(indiciesCount)
//                        print("ARRAYS")
//                        print(confidencePercentArray)
//                        print(matchUUIDArray)
                        // transform
                        for i in confidencePercentArray.indices{
                            transform.getData3(callback: {
//                                base64Strings = transform.imageBase64Array[0]
                                base64StringsArray = transform.imageBase64Array
//                                print("Array")
//                                print(base64StringsArray)
                                
                                if i == indiciesCount-1 {
                                    print("Finish Area")
                                    finish = true
                                }
                            }, faceUUID: matchUUIDArray[i])
                        }
                      
                               
                       
                            
                        
                        
//                        print("Array")
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
