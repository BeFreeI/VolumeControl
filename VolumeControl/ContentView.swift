//
//  ContentView.swift
//  VolumeControl
//
//  Created by  Pavel Nepogodin on 20.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VolumeControl(progress: $progress) 
                    .frame(width: 100, height: 200)
                Spacer()
            }.ignoresSafeArea()
            Spacer()
        }.ignoresSafeArea()
            .background(.gray.opacity(0.8))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
