//
//  ContentView.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/12.
//

import SwiftUI

struct ContentView: View {
    //Log Status
    @AppStorage("log_status") var logStatus = false
    var body: some View {
        
        NavigationView {
            if logStatus {
                Home()
            }
            else {
                LoginPage()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
