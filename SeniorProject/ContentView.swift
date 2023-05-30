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
    @StateObject var ninjaCeleb = NinjaCeleb()
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
    
    
    @State var netWorthArray : [Int] = []
    @State var genderArray : [String] = []
    @State var occupationArray : [String] = []
    @State var heightArray : [Double] = []
    @State var birthdayArray : [String] = []
    @State var ageArray : [Int] = []
    @State var isAliveArray : [String] = []
    
    @State var originalFace : String = ""
    
    @State var count : Int = 0
    let backgroundGradient = LinearGradient(
        colors: [Color.red, Color.red],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
  NavigationView{
        ZStack{
            backgroundGradient
            VStack{
//                Image("FinderOfFame").resizable().frame(width: 400, height: 75).offset(y: -30)
                VStack {
                    Image("FinderFame").resizable().background(Color.B1).clipShape(Rectangle()).shadow(color: Color.G3, radius: 14).overlay(Rectangle().stroke(Color.white,lineWidth: 0)).frame(width: 210, height: 210).scaledToFit ().frame(alignment: .top)
                        .padding()
                   
                    //uploaded image
                    if let image = selectedImage {
                        VStack{
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 300).shadow(color: Color.G3, radius: 15)
//                                .aspectRatio(image.size, contentMode: .fit)
                            //                            .border(Color.black, width: 2)
                                .padding()
                        }
                    } else {
                        VStack{
                            Image("FameFinder")
                                .resizable()
                                .frame(width: 250, height: 300)
                                .aspectRatio(contentMode: .fit)
                            //                            .border(Color.black, width: 2)
                                .opacity(0.0)
                            Text("No image selected").font(Font.system(size: 20, weight: .bold)).foregroundColor(Color.white)
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
                            ninjaCeleb.ninjaBool = true
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
                            ninjaCeleb.ninjaBool = true
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
                        
                        NavigationLink(destination : SearchInfo(base64StringsArray: $base64StringsArray, confidenceLevel: $confidenceLevel, selectedImage: $selectedImage, base64Strings: $base64Strings, indiciesCount: $indiciesCount, personIDArrayThing: $personIDArrayThing, count: $count, confidencePercentArray: $confidencePercentArray, finish: $finish, netWorthArray: $netWorthArray, genderArray: $genderArray, occupationArray: $occupationArray, heightArray: $heightArray, birthdayArray: $birthdayArray, ageArray: $ageArray, isAliveArray: $isAliveArray, originalFace: $originalFace).onAppear{
                            
                                netWorthArray.append(0)
                                genderArray.append("No Result")
                                occupationArray.append("No Result")
                                heightArray.append(0.0)
                                birthdayArray.append("No Result")
                                ageArray.append(0)
                                isAliveArray.append(String(false))
                            
                            uploadImage(selectedImage: selectedImage)
                            
                            
                        }){
                            
                            Image(systemName: "magnifyingglass").foregroundColor(Color.red) .font(Font.system(size: 25, weight: .semibold))
                            Text("Search").font(Font.system(size: 20, weight: .bold))
                            
                        }
                    }).padding().background(Color.black
                    ).clipShape(Capsule()).foregroundColor(.G3)
                    
                    
                }.ignoresSafeArea()
            }
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
//                                print(name)
                                personIDArrayThing[i] = name!
                        }
                        indiciesCount = recognizeUUID.indicies
//                        print("ARRAYS")
//                        print(confidencePercentArray)
//                        print(matchUUIDArray)
//                        print(personIDArrayThing)
                        
                        // Calls Transform.GetData
                        
                        originalFace = recognizeUUID.OGFace
                        transform.getData3(callback: {
                            originalFace = transform.responses3.image_base64!
                            transform.transformBool = true
                        }, faceUUID: originalFace)
                        
                        processTransformData(index: 0)
                        
                        
                        
                    }, recognizeUUIDString: recognizeUUIDStringThing)
                }, faceUUID: UserUUID!)
            }, selectedImageURL: imageURL)
        }
        
 else {
            print("Error converting image to data")
        }
    }
    
    func processTransformData(index: Int) {
        guard index < confidencePercentArray.count else {
           //smt
           
            return
        }

        transform.getData3(callback: {
            if index == indiciesCount-1 {
                        print("Finish Area")
    
                finish = true
                    }

            // gets celeb information
            ninjaCeleb.getData5(callback: {
                netWorthArray = ninjaCeleb.netWorth
                
                base64StringsArray = transform.imageBase64Array
                
                genderArray = ninjaCeleb.gender
                occupationArray = ninjaCeleb.occupation
                heightArray = ninjaCeleb.height
                birthdayArray = ninjaCeleb.birthday
                ageArray = ninjaCeleb.age
                isAliveArray = ninjaCeleb.isAlive

            }, personName: personIDArrayThing[index])
//            print("Array")
            processTransformData(index: index + 1)
        }, faceUUID: matchUUIDArray[index])
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
