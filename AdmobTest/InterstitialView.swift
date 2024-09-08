import SwiftUI
import GoogleMobileAds

struct InterstitialView: View {
    @StateObject private var adManager = InterstitialManager(adUnitID: "ca-app-pub-3940256099942544/4411468910")

    var body: some View {
        VStack {
            Text("This is Interstitial Ad :P")
                .padding()
            
            Button("Show Interstitial Ad") {
                adManager.showAd()
            }
            .disabled(!adManager.isAdLoaded)
            .padding()
        }
        .onAppear {
            adManager.loadAd()
        }
    }
}

class InterstitialManager: NSObject, ObservableObject, GADFullScreenContentDelegate {
    private var interstitialAd: GADInterstitialAd?
    @Published var isAdLoaded = false
    private let adUnitID: String

    init(adUnitID: String) {
        self.adUnitID = adUnitID
        super.init()
        loadAd()
    }

    func loadAd() {
        GADInterstitialAd.load(withAdUnitID: adUnitID, request: GADRequest()) { [weak self] ad, error in
            if error != nil { print("Failed to load ad."); return }
            self?.interstitialAd = ad
            self?.interstitialAd?.fullScreenContentDelegate = self
            self?.isAdLoaded = true
            print("Ad loaded.")
        }
    }

    func showAd() {
        guard let ad = interstitialAd, let rootVC = UIApplication.shared.windows.first?.rootViewController else {
            print("Ad not ready.")
            return
        }
        ad.present(fromRootViewController: rootVC)
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad dismissed.")
        isAdLoaded = false
        loadAd()
    }
}

#Preview {
    InterstitialView()
}
