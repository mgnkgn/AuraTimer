//
//  ContentView.swift
//  CalmTime
//
//  Created by Gunes Akgun on 27.03.2025.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@EnvironmentObject var themeManager: ThemeManager

    var body: some View {
		VStack{
			
			Spacer()
			HStack{
				if themeManager.isActive {
					// Stop Button
					Image(systemName: "pause.circle.fill")
						.resizable()
						.frame(width: 50, height: 50)
						.foregroundColor(.black)
						.padding()
						.shadow(color: .white, radius: 1)
						.onTapGesture {
							themeManager.stopSound()
						}
					
					// Finish Button
					Image(systemName: "stop.circle.fill")
						.resizable()
						.frame(width: 50, height: 50)
						.foregroundColor(.black)
						.padding()
						.shadow(color: .white, radius: 1)
						.onTapGesture {
							themeManager.finishSession()
						}
					
					
				} else {
					VStack{
						HStack{
							TimeOptions()
						}
						// Play Button
						Image(systemName: "play.circle.fill")
							.resizable()
							.frame(width: 50, height: 50)
							.foregroundColor(.black)
							.padding()
							.shadow(color: .white, radius: 1)
							.onTapGesture {
								themeManager
									.playSound()
								print(themeManager.player ?? "not playing")
							}
							
					}
				}
			}
			Spacer()
			
			
			ZStack {
				HStack{
					Image(systemName: "arrow.left.square.fill")
						.resizable()
						.frame(width: 50, height: 50)
						.foregroundColor(.black)
						.padding()
						.shadow(color: .white, radius: 1)
						.onTapGesture {
							themeManager.changeTheme(next: false)
						}
					
					TimeClock()
					
					
					Image(systemName: "arrow.right.square.fill")
						.resizable()
						.frame(width: 50, height: 50)
						.foregroundColor(.black)
						.padding()
						.shadow(color: .white, radius: 1)
						.onTapGesture {
							themeManager.changeTheme(next: true)
						}
				}
				
			}
			
			Spacer()
			HStack {
				GADBannerViewController()
					.frame(width: UIScreen.main.bounds.size.width,
						   height: 50)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background() {
			Image(themeManager.currentTheme.backgroundImage)
				.resizable()
				.ignoresSafeArea()
		}
		.gesture(
			DragGesture()
				.onEnded({ value in
					if value.translation.width < 50 {
						themeManager.changeTheme(next: true)
					} else if value.translation.width > -50 {
						themeManager.changeTheme(next: false)
					}
				})
		)
		
	}
	
	
	
	

   
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}



