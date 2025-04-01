//
//  TimeOptions.swift
//  CalmTime
//
//  Created by Gunes Akgun on 1.04.2025.
//

import SwiftUI

struct TimeOptions: View {
	@EnvironmentObject var themeManager: ThemeManager
	
	var body: some View {
		VStack(spacing: 20) {
		
			// Predefined time options
			HStack {
				Button(action: {
					setTime(minutes: 10)
				}) {
					Text("10 min")
						.font(.title2)
						.padding(.horizontal, 20)
						.padding(.vertical, 7)
						.background(Color.black)
						.foregroundColor(.white)
						.cornerRadius(30)
						.shadow(color: .gray, radius: 1)
				}
				
				Button(action: {
					setTime(minutes: 20)
				}) {
					Text("20 min")
						.font(.title2)
						.padding(.horizontal, 20)
						.padding(.vertical, 7)
						.background(Color.black)
						.foregroundColor(.white)
						.cornerRadius(30)
						.shadow(color: .gray, radius: 1)
				}
				
				Button(action: {
					setTime(minutes: 30)
				}) {
					Text("30 min")
						.font(.title2)
						.padding(.horizontal, 20)
						.padding(.vertical, 7)
						.background(Color.black)
						.foregroundColor(.white)
						.cornerRadius(30)
						.shadow(color: .gray, radius: 1)
				}
			}
		}
		.padding()
	}
	
	// Helper function to set time based on predefined options
	func setTime(minutes: Int) {
		themeManager.setTime(hours: 0, minutes: minutes, seconds: 0)
	}
}

#Preview {
	TimeOptions()
		.environmentObject(ThemeManager())
}
