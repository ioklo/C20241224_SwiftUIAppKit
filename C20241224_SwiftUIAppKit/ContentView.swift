//
//  ContentView.swift
//  C20241224_SwiftUIAppKit
//
//  Created by 이승중 on 12/24/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            NSViewControllerRepresentableDemo()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
