//
//  SideMenuView.swift
//  FireBaseValidateEmail$Passord
//
//  Created by Guru Mahan on 07/02/23.
//

import SwiftUI

struct SideMenuView: View {
 
    let menuWidth: CGFloat = (UIScreen.main.bounds.width * 0.8)
    @Binding var isMenuVisible: Bool
    @State var  isUserInfoShow: Bool = false
    @State var isSignOut = false
    var body: some View {
     //   NavigationView {
            ZStack {
                NavigationLink(isActive: $isSignOut) {
                LoginView()
            } label: {
                EmptyView()
            }

                
                GeometryReader{ _ in
                  EmptyView()
                }
                .background(Color.black.opacity(0.3))
                .opacity(isMenuVisible ? 1.0 : 0.0)
                    .animation(Animation.easeIn.delay(0.2))
                    .onTapGesture {
                        isMenuVisible.toggle()
                    }
                HStack{
                    VStack{
                        profileView
                            .background(Color.blue)
                        Divider()
                        menuListView
                        Spacer()
                    }
                    .frame(width: menuWidth)
                    .background(Color.white)
                    .offset(x: isMenuVisible ? 0: -menuWidth)
                    .animation(.default)
                    Spacer()
                    
                }
                
            }
    //    }

    }
   
    
    @ViewBuilder var profileView: some View{
        VStack{
            HStack(alignment: .center){
                NavigationLink {
                
                } label: {
                    Image(systemName: "paperplane.circle")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .foregroundColor(.white)
                        .frame(width: 67, height: 67)
                        .clipShape(Circle())
                        .padding(.vertical, 15)
                        .padding(.leading)
                }
                userSummaryView
                Spacer()
 
            }
            HStack{
                if isUserInfoShow{
                    userDetailsView
                        .padding(.leading)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder var userSummaryView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("")
                    .font(.system(size: 14))
                Button {
                    isUserInfoShow.toggle()
                } label: {
                    Image(systemName: "arrow.down.to.line.circle")
                        .foregroundColor(Color.white)
                }
            }
            Text("")
                .font(.system(size: 18))
        }
    }
    
    @ViewBuilder var userDetailsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("ENROLED PROGRAM")
                .foregroundColor(.white)
            Text("Program1")
                .foregroundColor(.white)
            Text("ENROLED TERM")
                .foregroundColor(.white)
            Text("Regular")
                .foregroundColor(.white)
            Text("ENROLED DATE")
                .foregroundColor(.white)
            Text("29/12/2022")
                .foregroundColor(.white)
            Text("EMAIL")
                .foregroundColor(.white)
           // Text(viewModel.emailId)
        }
        .font(.system(size: 14))
    }
    
    @ViewBuilder var menuListView: some View {
        VStack {
            dashboardMenuView
            coursesMenuView
            calendarMenuView
            helpMenuView
            Spacer()
            signOutButton
                .frame(height: 50)
                .padding()
        }
    }
    
    @ViewBuilder var dashboardMenuView: some View {
        HStack(spacing: 16) {
            Image("dashboard")
                .resizable()
                .frame(width: 12, height: 12)
            NavigationLink("Dashboard", destination: Text("Dashboard"))
                .font(.system(size: 14, weight: .semibold))
            Spacer()
        }
        .foregroundColor(Color.gray)
        .padding()
    }
    
    @ViewBuilder var coursesMenuView: some View {
        HStack(spacing: 16) {
            Image("folder")
                .resizable()
                .frame(width: 14, height: 11)
            NavigationLink("Courses", destination: Text("Courses"))
                .font(.system(size: 14, weight: .semibold))
            Spacer()
        }
        .foregroundColor(Color.gray)
        .padding()
    }
    
    @ViewBuilder var calendarMenuView: some View {
        HStack(spacing: 16) {
            Image("calendar")
                .resizable()
                .frame(width: 12, height: 13)
            NavigationLink("Calendar", destination: Text("Calendar"))
                .font(.system(size: 14, weight: .semibold))
            Spacer()
        }
        .foregroundColor(Color.gray)
        .padding()
    }
    
    @ViewBuilder var helpMenuView: some View {
        HStack(spacing: 16) {
            Image(systemName: "questionmark.square.fill")
                .resizable()
                .frame(width: 14, height: 14)
            NavigationLink("Help", destination: Text("Help"))
                .font(.system(size: 14, weight: .semibold))
            Spacer()
        }
        .foregroundColor(Color.gray)
        .padding()
    }
    
    @ViewBuilder var signOutButton: some View {
        GeometryReader { geoReader in
           
            HStack(spacing: 16) {
                HStack(alignment: .center) {
                    Button {
                        UserDefaults.standard.set(false, forKey: "islogin")
                      isSignOut = true
                    } label: {
                        Text("Sign Out")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(width: geoReader.size.width * 0.7)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(24)
                            .padding()
                    }
                }
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isMenuVisible: .constant(true))
    }
}
