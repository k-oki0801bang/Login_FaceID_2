//
//  LoginPage.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/13.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    var body: some View {
        
        VStack {
            
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
                .offset(x: -23)
                .padding(.bottom, 30)
            
            Text("Hey, \nLogin Now")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hLeading()
            
            //TextFields
            TextField("Email", text: $loginModel.email)
                .padding()
                .background {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                        
                            loginModel.email == "" ? Color.black.opacity(0.05) : Color.orange)
                }
                //autocapitalixationの無効化
                .textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            TextField("password", text: $loginModel.password)
                .padding()
                .background {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                        
                            loginModel.password == "" ? Color.black.opacity(0.05) : Color.orange)
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 15)
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

//UI Designing
extension View {
    
    func hLeading()->some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()->some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
