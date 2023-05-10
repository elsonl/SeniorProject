//
//  SearchInfo.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/10/23.
//

import SwiftUI

struct SearchInfo: View {
    @Binding var base64String : String
    var body: some View {
        // Decode the String
        if let imageData = Data(base64Encoded: base64String) {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Failed to decode image")
            }
        } else {
            Text("Invalid base64 string")
        }    }
}

//struct SearchInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchInfo(base64String: Binding("Hello"))
//    }
//}
