//
//  Home.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/14.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    //Log Status
    @AppStorage("log_status") var logStatus = false
    
    //FaceIDのプロパティ
    @AppStorage("use_faceID") var useFaceID = false
    @AppStorage("use_face_email") var faceIDEmail = ""
    @AppStorage("use_face_password") var faceIDPassword = ""
    var body: some View {

        VStack(spacing: 20) {
            
            if logStatus {
                Text("Logged In")
                
                Button("Log out") {
                    try? Auth.auth().signOut()
                    logStatus = false
                }
            }
            else {
                Text("Came as Guest")
            }
            
            if useFaceID {
                //clearing faceID
                Button("Disable Face ID") {
                    useFaceID = false
                    faceIDEmail = ""
                    faceIDPassword = ""
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
