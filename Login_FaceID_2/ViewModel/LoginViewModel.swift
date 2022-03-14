//
//  LoginViewModel.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/13.
//

import SwiftUI
import LocalAuthentication
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    //FaceIDのプロパティ
    @AppStorage("use_faceID") var useFaceID = false
    @AppStorage("use_face_email") var faceIDEmail = ""
    @AppStorage("use_face_password") var faceIDPassword = ""
    
    //Log Status
    @AppStorage("log_status") var logStatus = false
    
    //Error
    @Published var showError = false
    @Published var errorMsg = ""
    
    //Firebase Login
    //同期処理　async await
    func loginUser(useFaceID: Bool, email: String = "", password: String = "") async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        
        //非同期処理
        DispatchQueue.main.async {
            
            if useFaceID && self.faceIDEmail == "" {
                self.useFaceID = useFaceID
                //Storing for future face ID Login
                self.faceIDEmail = self.email
                self.faceIDPassword = self.password
            }
            
            self.logStatus = true
        }
    }
    
    //FaceID Usage
    func getBioMetricStatus()->Bool {
        //生体認証を管理クラスを生成
        let scanner = LAContext()
        
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    //FaceID Login
    func authenticateUser() async throws {
        
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Login Into App")
        
        if status {
            try await loginUser(useFaceID: useFaceID, email: self.faceIDEmail, password: self.faceIDPassword)
        }
    }
}
