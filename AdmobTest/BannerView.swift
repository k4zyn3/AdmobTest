//
//  BannerView.swift
//  AdmobTest
//
//  Created by 湊日利 on 2024/09/08.
//


import SwiftUI
import GoogleMobileAds

struct BannerView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("This is Banner Ad :)")
            
            Spacer()
            
            AdBannerView(adUnitID: "ca-app-pub-3940256099942544/2934735716")
                .frame(height: 70)
        }
        .padding()
    }
}

struct AdBannerView: UIViewRepresentable {
    let adUnitID: String
    
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: 320, height: 50)))
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
        bannerView.load(GADRequest())
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}

#Preview {
    BannerView()
}
