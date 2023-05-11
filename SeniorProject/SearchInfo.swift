//
//  SearchInfo.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/10/23.
//

import SwiftUI

struct SearchInfo: View {
    @Binding var base64StringsArray : [String]
    @Binding var confidenceLevel : Double
    @Binding var selectedImage: UIImage?
    @Binding var base64Strings : String
    @Binding var indiciesCount : Int
    @Binding var personIDArrayThing : [String]
    @State var count : Int = 0
    @Binding var confidencePercentArray: [Double]
    @Binding var finish : Bool
    @State var toView : Bool = false
    
    let backgroundGradient = LinearGradient(
        colors: [Color.G1, Color.G1],
        startPoint: .top, endPoint: .bottom)

    
    var body: some View {
        // Decode the String
        NavigationView{
            if toView {
                ZStack{
                    backgroundGradient
                    VStack{
                        HStack{
                            VStack{
                                Text("Your Image").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                                if let image = selectedImage {
                                    VStack{
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 200.0, height: 200.0)
                                            .aspectRatio(image.size, contentMode: .fit)
        //                                    .border(Color.black, width: 2)
                                    }
                                } else {
                                    Text("No image selected").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                                }
                            }
                            
                            VStack{
                                Text("Result: " + String(count + 1) + "/" + String(indiciesCount)).font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                                if let imageData = Data(base64Encoded: base64StringsArray[count]) {
                                    if let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                            .aspectRatio(contentMode: .fit)
                                    } else {
                                        Text("Failed to decode image").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                                    }
                                } else {
                                    Text("Invalid base64 string").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                                }
                            }
                        }
                        VStack{
                            Button(action: {
                                if count < indiciesCount-1{
                                    count += 1
                                } else {
                                    count = 0
                                }
                            }) {
                                Text("Next").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding().background(Color.black)
                            }.clipShape(Capsule()).padding()
                            
                                Text(personIDArrayThing[count]).font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                            HStack{
                                Text("Similarity Confidence: ").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                                Text("\(confidencePercentArray[count] * 100, specifier: "%.2f")%").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                            }
                        }

            
                    }.ignoresSafeArea()
                    
                    
                }.ignoresSafeArea()
            } else {
                Loading_Screen(toView: $toView, finish: $finish)
            }
        }.navigationViewStyle(StackNavigationViewStyle()).navigationBarBackButtonHidden(false)
    }
    
//    struct SearchInfo_Previews: PreviewProvider {
//        static var previews: some View {
//            SearchInfo(base64String: .constant("hello"), confidenceLevel: .constant(0.78), selectedImage: .constant(UIImage(Image("FameFinder"))))
//        }
//    }
}
