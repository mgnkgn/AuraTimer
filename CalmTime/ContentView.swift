//
//  ContentView.swift
//  CalmTime
//
//  Created by Gunes Akgun on 27.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
		ZStack {
			TimeClock()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background() {
			Image("forest-i")
				.resizable()
				.ignoresSafeArea()
		}
		.onAppear(){
			
		}
	}
	
	
	
	

   
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
