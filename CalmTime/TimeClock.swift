//
//  TimeClock.swift
//  CalmTime
//
//  Created by Gunes Akgun on 27.03.2025.
//

import SwiftUI
import AVFoundation

struct TimeClock: View {
	@State private var timeRemaining = 60 * 24
	
	let timer = Timer.publish(
		every: 1,
		on: .main,
		in: .common
	).autoconnect()
	
	@Environment(\.scenePhase) var scenePhase
	@State private var isActive: Bool = false
	
	@State private var player: AVAudioPlayer?
	
	
	var body: some View {
		ZStack{
			Text(timeFormatted(timeRemaining))
				.font(.system(size: 50, weight: .bold, design: .rounded))
				.foregroundColor(.black)
			
			Circle()
				.fill(
					Color.clear
				)
				.stroke(
					Color.black,
					lineWidth: 5
				)
				.frame(
					width: 250,
					height: 250
				)
				
		}
		.onReceive(timer) { _ in
			guard isActive else { return }
			
			if self.timeRemaining > 0 {
				self.timeRemaining -= 1
			}
		}
		.onChange(of: scenePhase) { oldValue, newValue in
			if newValue == .active {
				self.isActive = true
			} else {
				self.isActive = false
			}
		}
		.onAppear(){
			playSound()
		}
    }
	
	func playSound() {
	  guard let soundURL = Bundle.main.url(forResource: "forest-sound", withExtension: "wav") else {
		return
	  }

	  do {
		player = try AVAudioPlayer(contentsOf: soundURL)
	  } catch {
		print("Failed to load the sound: \(error)")
	  }
	  player?.play()
	}
	
	func timeFormatted(_ totalSeconds: Int) -> String {
		  let hours = totalSeconds / 3600
		  let minutes = (totalSeconds % 3600) / 60
		  let seconds = totalSeconds % 60
		  
		  if hours > 0 {
			  return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
		  } else {
			  return String(format: "%02d:%02d", minutes, seconds)
		  }
	  }
		
}

#Preview {
    TimeClock()
}
