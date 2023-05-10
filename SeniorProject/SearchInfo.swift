//
//  SearchInfo.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/10/23.
//

import SwiftUI

struct SearchInfo: View {
    @Binding var base64String : String
    @Binding var confidenceLevel : Double
    @Binding var selectedImage: UIImage?
    
    let backgroundGradient = LinearGradient(
        colors: [Color.G1, Color.G1],
        startPoint: .top, endPoint: .bottom)

    
    var body: some View {
        // Decode the String
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
                                    .aspectRatio(image.size, contentMode: .fill)
                                    .border(Color.black, width: 2)
                            }
                        } else {
                            Text("No image selected").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                        }
                    }
                    
                    VStack{
                        Text("Results").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                        if let imageData = Data(base64Encoded: base64String) {
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
                HStack{
                    Text("Similarity Confidence: ").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                    Text("\(confidenceLevel * 100, specifier: "%.2f")%").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                }

    
            }.ignoresSafeArea()
            
            
        }.ignoresSafeArea()
    }
    
//    struct SearchInfo_Previews: PreviewProvider {
//        static var previews: some View {
//            SearchInfo(base64String: .constant("hello"), confidenceLevel: .constant(0.78), selectedImage: .constant(UIImage(Image("FameFinder"))))
//        }
//    }
}
