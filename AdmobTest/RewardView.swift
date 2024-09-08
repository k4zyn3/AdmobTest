import SwiftUI
import GoogleMobileAds

struct RewardView: View {
    @StateObject private var adManager = RewardedAdManager()
    private let adUnitID = "ca-app-pub-3940256099942544/1712485313"

    var body: some View {
        VStack{
            Text("This is reward Ad :q")
                .padding()
            
            Button("Click here to show reward Ad") {
                adManager.showAd()
            }
            .disabled(!adManager.isAdLoaded)
            .onAppear {
                adManager.loadAd(adUnitID: adUnitID)
            }
        }
        .padding()
    }
}

class RewardedAdManager: NSObject, ObservableObject, GADFullScreenContentDelegate {
    private var rewardedAd: GADRewardedAd?
    @Published var isAdLoaded = false
    private var adUnitID = ""

    func loadAd(adUnitID: String) {
        self.adUnitID = adUnitID
        GADRewardedAd.load(withAdUnitID: adUnitID, request: GADRequest()) { [weak self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad: \(error.localizedDescription)")
                return
            }
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
            self?.isAdLoaded = true
        }
    }

    func showAd() {
        guard let ad = rewardedAd, let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("Ad wasn't ready")
            return
        }
        ad.present(fromRootViewController: rootViewController) {
            print("User earned reward of \(ad.adReward.amount) \(ad.adReward.type)")
        }
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad dismissed.")
        isAdLoaded = false
        loadAd(adUnitID: adUnitID)
    }
}

#Preview {
    RewardView()
}
