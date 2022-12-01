//
//  ContentView.swift
//  BucketList
//
//  Created by Saurabh Jamadagni on 10/11/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) {location in
                MapAnnotation(coordinate: location.coordinates) {
                    
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .font(.footnote)
                            .fixedSize()
                    }
                    .onTapGesture {
                        vm.selectedPlace = location
                    }
                }
            }
            .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        vm.addLocation()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.7))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $vm.selectedPlace) { place in
            EditView(location: place) { newLocation in
                vm.update(location: newLocation)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
