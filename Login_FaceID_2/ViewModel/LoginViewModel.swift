//
//  LoginViewModel.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/13.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
}
