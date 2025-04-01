//
//  ThemeManager.swift
//  CalmTime
//
//  Created by Gunes Akgun on 30.03.2025.
//

import SwiftUI
import AVFoundation

class ThemeManager: ObservableObject {
	@Published var currentThemeIndex = 0
	
	let themes: [Theme] = [
		Theme(name: "Forest", backgroundImage: "forest-i", soundFile: "forest-sound"),
		Theme(name: "Waterfall", backgroundImage: "waterfall-i", soundFile: "waterfall"),
		Theme(name: "Campfire", backgroundImage: "campfire-i", soundFile: "campfire"),
		Theme(name: "Waves", backgroundImage: "waves", soundFile: "waves"),
		Theme(name: "Cosmic", backgroundImage: "cosmic", soundFile: "cosmic"),
		Theme(name: "Peak", backgroundImage: "peak", soundFile: "peak")
	]
	
	var player: AVAudioPlayer?
	
	@Published var selectedHours = 0
	@Published var selectedMinutes = 20
	@Published var selectedSeconds = 0
	
	@Published var totalTime: Int = 20 * 60
	@Published var timeRemaining: Int = 20 * 60
	
	@Published var isActive: Bool = false
	
	let timer = Timer.publish(
		every: 1,
		on: .main,
		in: .common
	).autoconnect()
	
	init() {
		loadTheme()
	}
	
	var currentTheme: Theme {
		   return themes[currentThemeIndex]
	}
	
	func saveTheme() {
			UserDefaults.standard.set(currentThemeIndex, forKey: "selectedThemeIndex")
	}
	
	func loadTheme() {
		if let index = UserDefaults.standard.value(forKey: "selectedThemeIndex") as? Int,
			index < themes.count {
			currentThemeIndex = index
		}
	}
	
	func playSound() {
		print("called")
		
		guard let url = Bundle.main.url(forResource: currentTheme.soundFile, withExtension: "wav") else { return }
		do {
			player = try AVAudioPlayer(contentsOf: url)
			player?.numberOfLoops = -1 // Loop forever
			player?.play()
			
			
			isActive = true
		} catch {
			print("Error playing sound: \(error.localizedDescription)")
		}
	}
	
	func stopSound() {
		player?.stop()
		isActive = false
	}
	
	func finishSession() {
		stopSound()
		timeRemaining = 0
		isActive = false
	}
	
	func changeTheme(next: Bool) {
		if next {
			currentThemeIndex = (currentThemeIndex + 1) % themes.count
		} else {
			currentThemeIndex = (currentThemeIndex - 1 + themes.count) % themes.count
		}
		saveTheme()
		
		if let player = player, player.isPlaying && isActive {
			stopSound()
			playSound()
		}
	}
	
	func setTime(hours: Int, minutes: Int, seconds: Int) {
		selectedHours = hours
		selectedMinutes = minutes
		selectedSeconds = seconds
		
		// Calculate total time in seconds
		totalTime = (hours * 3600) + (minutes * 60) + seconds
		timeRemaining = totalTime
	}
	
}
