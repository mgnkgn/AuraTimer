//
//  TimeClock.swift
//  CalmTime
//
//  Created by Gunes Akgun on 27.03.2025.
//

import SwiftUI

struct TimeClock: View {
	@Environment(
		\.scenePhase
	) var scenePhase
	@EnvironmentObject var themeManager: ThemeManager
	
	@State private var selectedHours = 0
	@State private var selectedMinutes = 20
	@State private var selectedSeconds = 0
		
	var body: some View {
		ZStack{
			
			if themeManager.isActive {
				Text(
					timeFormatted(
						themeManager.timeRemaining
					)
				)
				.font(
					.system(
						size: 50,
						weight: .bold,
						design: .rounded
					)
				)
				.foregroundColor(
					.black
				)
				.shadow(color: .white, radius: 1)
			} else {
				HStack {
					Picker(
						"Hours",
						selection: $themeManager.selectedHours
					) {
						ForEach(
							0..<24
						) { hour in
							Text(
								"\(hour)h"
							)
							.fontWeight(.bold)
							.foregroundStyle(Color.black)
							.shadow(color: .white, radius: 1)
							.tag(
								hour
							)
						}
					}
					.pickerStyle(
						WheelPickerStyle()
					)
					.frame(
						width: 80
					)
					.onChange(
						of: themeManager.selectedHours
					) { _,_ in
						themeManager
							.setTime(
								hours: themeManager.selectedHours,
								minutes: themeManager.selectedMinutes,
								seconds: themeManager.selectedSeconds
							)
					}
					
					Picker(
						"Minutes",
						selection: $themeManager.selectedMinutes
					) {
						ForEach(
							0..<60
						) { minute in
							Text(
								"\(minute)m"
							)
							.fontWeight(.bold)
							.foregroundStyle(Color.black)
							.shadow(color: .white, radius: 1)
							.tag(
								minute
							)
						}
					}
					.pickerStyle(
						WheelPickerStyle()
					)
					.frame(
						width: 80
					)
					.onChange(
						of: themeManager.selectedMinutes
					) { _,_ in
						themeManager
							.setTime(
								hours: themeManager.selectedHours,
								minutes: themeManager.selectedMinutes,
								seconds: themeManager.selectedSeconds
							)
					}
					
					Picker(
						"Seconds",
						selection: $themeManager.selectedSeconds
					) {
						ForEach(
							0..<60
						) { second in
							Text(
								"\(second)s"
							)
							.fontWeight(.bold)
							.foregroundStyle(Color.black)
							.shadow(color: .white, radius: 1)
							.tag(
								second
							)
						}
					}
					.pickerStyle(
						WheelPickerStyle()
					)
					.frame(
						width: 80
					)
					.onChange(
						of: themeManager.selectedSeconds
					) { _,_ in
						themeManager
							.setTime(
								hours: themeManager.selectedHours,
								minutes: themeManager.selectedMinutes,
								seconds: themeManager.selectedSeconds
							)
								   }
							   }
							
			}
			
			
			
			
			Circle()
				.trim(
					from: 0.0,
					to: progress()
				)
				.stroke(
					Color.black,
					style: StrokeStyle(
						lineWidth: 10,
						lineCap: .round
					)
				)
				.rotationEffect(
					.degrees(
						-90
					)
				)
				.frame(
					width: 250,
					height: 250
				)
				.shadow(color: .white, radius: 1)
				.animation(
					.easeInOut(
						duration: 1
					),
					value: themeManager.timeRemaining
				)
			
			Spacer()
			
		}
		.onReceive(
			themeManager.timer
		) { _ in
			guard themeManager.isActive else {
				return
			}
			
			if themeManager.timeRemaining > 0 {
				themeManager.timeRemaining -= 1
			} else {
				themeManager
					.stopSound()
			}
		}
		.onChange(
			of: scenePhase
		) {
			oldValue,
			newValue in
			if newValue == .active && themeManager.isActive {
				themeManager
					.playSound()
			} else {
				themeManager
					.stopSound()
			}
		}
	}
	
	
	func progress() -> CGFloat {
		return CGFloat(
			themeManager.timeRemaining
		) / CGFloat(
			themeManager.totalTime
		)
	}
		
	
	func timeFormatted(
		_ totalSeconds: Int
	) -> String {
		let hours = totalSeconds / 3600
		let minutes = (
			totalSeconds % 3600
		) / 60
		let seconds = totalSeconds % 60
		
		if hours > 0 {
			return String(
				format: "%02d:%02d:%02d",
				hours,
				minutes,
				seconds
			)
		} else {
			return String(
				format: "%02d:%02d",
				minutes,
				seconds
			)
		}
	}
}

#Preview {
	TimeClock()
		.environmentObject(
			ThemeManager()
		)
}
