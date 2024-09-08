import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: InterstitialView(), label:{
                    Text("InterstitialView")
                })
                .padding()
                
                NavigationLink(destination: BannerView(), label:{
                    Text("BannerView")
                })
                .padding()
                
                NavigationLink(destination: RewardView(), label:{
                    Text("RewardView")
                })
                .padding()
            }
            .navigationTitle("Google Admob ツ")
        }
    }
}

#Preview {
    ContentView()
}
