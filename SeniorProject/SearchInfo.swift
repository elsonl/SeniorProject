//
//  SearchInfo.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/10/23.
//

import SwiftUI

struct SearchInfo: View {
    @Environment(\.presentationMode) var presentationMode
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
        colors: [Color.G1, Color.G2],
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
                                Text("Your Image").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                                if let image = selectedImage {
                                    VStack{
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 150, height: 200.0)
                                            .aspectRatio(image.size, contentMode: .fit)
                                    }
                                } else {
                                    Text("No image selected").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                                }
                            }
                            
                            VStack{
                                Text("Result: " + String(count + 1) + "/" + String(indiciesCount)).font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                                if let imageData = Data(base64Encoded: base64StringsArray[count]) {
                                    if let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 150, height: 200)
                                            .aspectRatio(contentMode: .fit)
                                    } else {
                                        Text("Failed to decode image").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                                    }
                                } else {
                                    Text("Invalid base64 string").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                                }
                            }
                        }
                        VStack{
                            
                            HStack{
                                Button(action: {
                                    if count > 0 {
                                            count -= 1
                                        } else {
                                            count = indiciesCount - 1
                                        }
                                }) {
                                    Text("Back").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish).padding().background(Color.B1)
                                }.clipShape(Capsule()).padding()
                                
                                Button(action: {
                                    if count < indiciesCount-1{
                                        count += 1
                                    } else {
                                        count = 0
                                    }
                                }) {
                                    Text("Next").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish).padding().background(Color.B1)
                                }.clipShape(Capsule()).padding()
                            }
                            
                                Text(personIDArrayThing[count]).font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                            HStack{
                                Text("Similarity Confidence: ").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                                Text("\(confidencePercentArray[count] * 100, specifier: "%.2f")%").font(Font.system(size: 20, weight: .bold)).foregroundColor(.Orangish)
                            }
                        }

            
                    }.ignoresSafeArea()
                    
                    
                }.ignoresSafeArea()
            } else {
                Loading_Screen(toView: $toView, finish: $finish)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.Orangish)
                    .font(Font.system(size: 20, weight: .bold))
                Text("Back")  .foregroundColor(.Orangish)
                    .font(Font.system(size: 20, weight: .bold))
            })
      
    }
    
//    struct SearchInfo_Previews: PreviewProvider {
//        static var previews: some View {
//            SearchInfo(base64String: .constant("hello"), confidenceLevel: .constant(0.78), selectedImage: .constant(UIImage(Image("FameFinder"))))
//        }
//    }
}
