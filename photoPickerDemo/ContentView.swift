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
    @State private var data: Data?
    
    var body: some View {
        VStack {
            if let data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 200, height: 200)
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
                guard let item = selectedItem else { return }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data {
                            self.data = data
                        } else {
                            print("There is no data")
                        }
                    case .failure(let failure):
                        fatalError("\(failure)")
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
