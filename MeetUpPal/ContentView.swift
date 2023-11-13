//
//  ContentView.swift
//  MeetUpPal
//
//  Created by Peter Molnar on 29/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var meetupPals: FetchedResults<MeetupPal>
    
    @State private var showingAddImage = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(meetupPals) { meetingPal in
                        HStack {
                            Text(meetingPal.name ?? "No name found")
                            if let palImageFileURL = meetingPal.imagePath,
                                let uiImageData = try? Data(contentsOf: palImageFileURL),
                                let palUIImage = UIImage(data: uiImageData) {
                                // TODO: make the image view scale properly.
                                Image(uiImage: palUIImage)
                            } else {
                                Image(systemName: "circle")

                            }
                        }
                        }
                }
                
            }
            .navigationTitle("My MeetUp Pals")
            .toolbar {
                Button {
                    showingAddImage = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddImage) {
            AddNewPalView(moc: _moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
