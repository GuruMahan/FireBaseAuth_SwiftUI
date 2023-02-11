//
//  DashboardView.swift
//  FireBaseValidateEmail$Passord
//
//  Created by Guru Mahan on 07/02/23.
//

import SwiftUI

struct DashboardView: View {
    @State var isLoaderShown = false
    @State var  showLeftMenu = false
    var body: some View {
       NavigationView {
            ZStack {
                dashBoardView
                SideMenuView(isMenuVisible: $showLeftMenu)

             Spacer()
              
            }
            .onAppear{
                isLoaderShown = false
            }
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    @ViewBuilder var dashBoardView: some View{
        VStack(spacing:0){
            Color.blue
                .frame(height: UIScreen.main.safeAreaInsets.top)
            headerView
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        .loader(isShown: $isLoaderShown)
    }
   

    @ViewBuilder var headerView: some View{
        ZStack{
            Text("Dashboard")
            HStack{
                Button {
                    withAnimation {
                        DispatchQueue.main.async {
                           showLeftMenu = true
                          
                        }
                    }
                } label: {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 30))
                }
              Spacer()
                   
            }
        }
        .padding()
            .foregroundColor(.white)
            .frame(height: 55)
            .background(Color.blue)

    }
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

extension UIScreen {
    var safeAreaInsets: UIEdgeInsets {
        let first = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return first?.safeAreaInsets ?? .zero
    }
}
