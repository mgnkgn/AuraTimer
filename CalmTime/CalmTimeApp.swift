//
//  CalmTimeApp.swift
//  CalmTime
//
//  Created by Gunes Akgun on 27.03.2025.
//

import SwiftUI
import SwiftData
import GoogleMobileAds
import AppTrackingTransparency



@main
struct CalmTimeApp: App {
	
	
	init() {
		if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
		} else {
			ATTrackingManager.requestTrackingAuthorization { status in
				MobileAds.shared.start(completionHandler: nil)
			}
		}
	}
	
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
	
	@StateObject var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(themeManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
