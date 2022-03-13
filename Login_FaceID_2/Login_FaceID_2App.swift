//
//  Login_FaceID_2App.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/12.
//

import SwiftUI
import Firebase

@main
struct Login_FaceID_2App: App {
    //Firebaseの初期化コード
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
