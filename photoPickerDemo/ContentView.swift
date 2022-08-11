//
//  ContentView.swift
//  photoPickerDemo
//
//  Created by Vasichko Anna on 10.08.2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    var body: some View {
        VStack {
            if let selectedPhotoData, let image = UIImage(data: selectedPhotoData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .padding()
            }
            else {
                Image(systemName: "photo.circle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding()
            }
            PhotosPicker("Pick Photo", selection: $selectedItem)
                .onChange(of: selectedItem) { newValue in
                    Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                selectedPhotoData = data
                            }
                        }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
