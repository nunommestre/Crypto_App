//
//  HomeView.swift
//  Crypto App
//
//  Created by Nuno Mestre on 8/11/22.
//

import SwiftUI

struct HomeView: View {
  
  @State private var showPortfolio: Bool = false
  
  var body: some View {
      ZStack {
        Color.theme.background.ignoresSafeArea()
        ///content
        VStack{
          homeHeader
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
}
