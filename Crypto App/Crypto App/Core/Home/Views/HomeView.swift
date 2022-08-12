//
//  HomeView.swift
//  Crypto App
//
//  Created by Nuno Mestre on 8/11/22.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject private var vm: HomeViewModel
  @State private var showPortfolio: Bool = false
  
  var body: some View {
      ZStack {
        Color.theme.background.ignoresSafeArea()
        ///content
        VStack{
          homeHeader
          columnHeader
          
          if !showPortfolio {
            allCoinsList
          .transition(.move(edge: .leading))
          }
          if showPortfolio {
            portfolioCoinsList
          .transition(.move(edge: .trailing))
          }
          
          Spacer(minLength: 0)
        }
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView{
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(dev.homeVM)
    }
}

extension HomeView{
  private var homeHeader: some View{
    HStack{
      CircleButtonView(iconName: showPortfolio ? "chart.pie" : "chart.bar.xaxis")
        .animation(.none)
        .background(
          CircleButtonAnimationView(animate: $showPortfolio)
        )
      Spacer()
      Text(showPortfolio ? "Coins Followed" : "Live Prices")
        .animation(.none)
      Spacer()
    CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()){
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }
  private var allCoinsList: some View{
    List {
      ForEach(vm.allCoins) {
        coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  private var portfolioCoinsList: some View{
    List {
      ForEach(vm.portfolioCoins) {
        coin in
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  private var columnHeader: some View{
    HStack{
      Text("Coin")
      Spacer()
      if showPortfolio {
      Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(Color.theme.secondaryText)
    .padding(.horizontal)
  }
}
