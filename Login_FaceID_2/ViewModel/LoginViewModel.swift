//
//  LoginViewModel.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/13.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    //FaceIDのプロパティ
    @AppStorage("use_faceID") var useFaceID = false
    @AppStorage("use_face_email") var faceIDEmail = ""
    @AppStorage("use_face_password") var faceIDPassword = ""
    
    //Log Status
    @AppStorage("use_face_id") var logStatus = false
    
    //Firebase Login
    //同期処理　async await
    func loginUser() async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        
        if useFaceID {
            
            //Storing for future face ID Login
            faceIDEmail = email
            faceIDPassword = password
        }
        
        logStatus = true
    }
}
