//
//  GADBannerViewController.swift
//  CalmTime
//
//  Created by Gunes Akgun on 1.04.2025.
//

import Foundation
import GoogleMobileAds
import SwiftUI
import UIKit

struct GADBannerViewController: UIViewControllerRepresentable {

	@State private var banner: BannerView = BannerView(adSize: AdSizeBanner)
	let adSize = adSizeFor(cgSize: CGSize(width: UIScreen.main.bounds.size.width, height: 50))

	func makeUIViewController(context: Context) -> UIViewController {
		
		let bannerSize = adSize
		let viewController = UIViewController()
		banner.adSize = bannerSize

		
		//banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"// testID
		banner.adUnitID = "ca-app-pub-6297830725022299/3739367204"
		banner.rootViewController = viewController
		viewController.view.addSubview(banner)
		viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
		banner.load(Request())
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIViewController, context: Context){
		let bannerSize = adSize
		banner.frame = CGRect(origin: .zero, size: bannerSize.size)
		banner.load(Request())
	}
}

struct Banner_Previews: PreviewProvider {
	static var previews: some View {
		HStack {
			GADBannerViewController()
				.frame(width: UIScreen.main.bounds.size.width, height: 50)
		}
	}
}
