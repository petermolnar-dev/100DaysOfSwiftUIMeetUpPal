//
//  AddNewPalView.swift
//  MeetUpPal
//
//  Created by Peter Molnar on 05/06/2023.
//

import SwiftUI

struct AddNewPalView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var showingAddImage = false
    @State private var buddyName = ""

    var body: some View {
        NavigationView {
            VStack {
                if selectedImage == nil {
                    Text("Please select an image")
                } else {
                    image?
                        .resizable()
                        .scaledToFit()
                        .padding(.all)
                    TextField("Name", text: $buddyName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.all)
                }
                
            }
            .navigationTitle("Add new Meetup Pal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Save") {
                        let currentID = UUID()
                        if let selectedImage = selectedImage,
                           let jpegData = selectedImage.jpegData(compressionQuality: 0.8) {
                            let imageFileURL = FileManager.documentsDirectory.appendingPathComponent(currentID.uuidString, conformingTo: .fileURL)
                            try? jpegData.write(to: imageFileURL, options: [.atomic, .completeFileProtection])
                            let pal = MeetupPal(context: moc)
                            pal.id = currentID
                            pal.imagePath = imageFileURL
                            pal.name = buddyName
                            try? moc.save()
                        }
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if selectedImage == nil {
                        Button("New") {
                            showingAddImage = true
                        }
                    } else {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                }

            }
        }
        .onChange(of: selectedImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingAddImage) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    private func loadImage() {
        if let selectedImage = selectedImage {
            image = Image(uiImage: selectedImage)
        }
    }
}

struct AddNewPalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPalView()
    }
}
