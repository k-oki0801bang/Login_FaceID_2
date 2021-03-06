//
//  LoginPage.swift
//  Login_FaceID_2
//
//  Created by 山田滉暁 on 2022/03/13.
//

import SwiftUI
import LocalAuthentication

struct LoginPage: View {
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @State var useFaceID = false
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
                        
                            loginModel.email == "" ? Color.black.opacity(0.05) : Color.black.opacity(0.2))
                }
                //autocapitalixationの無効化
                .textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            //SecureField(テキストの非表示)
            SecureField("password", text: $loginModel.password)
                .padding()
                .background {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                        
                            loginModel.password == "" ? Color.black.opacity(0.05) : Color.black.opacity(0.2))
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            if loginModel.getBioMetricStatus() {
                
                Group {
                    if loginModel.useFaceID {
                        
                        Button {
                            //FaceID実行
                            Task {
                                do {
                                    try await loginModel.authenticateUser()
                                }
                                catch {
                                    loginModel.errorMsg = error.localizedDescription
                                    loginModel.showError.toggle()
                                }
                            }
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Label {
                                    Text("Use FaceID to login into previous account")
                                } icon: {
                                    
                                    Image(systemName: "faceid")
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                Text("Note: You can turn of it in setting!")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                        .hLeading()
                    }
                    else {
                        //Toggleボタン
                        Toggle(isOn: $useFaceID) {
                            Text("Use FaceID to Login")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            
            Button {
                Task {
                    do {
                        try await loginModel.loginUser(useFaceID: useFaceID)
                    }
                    catch {
                        loginModel.errorMsg = error.localizedDescription
                        loginModel.showError.toggle()
                    }
                }

            } label: {
                
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .hCenter()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 0.65, green: 0, blue: 0.30))
                    )
            }
            .padding(.vertical, 35)
            .disabled(loginModel.email == "" || loginModel.password == "")
            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
            
            NavigationLink {
                
            } label: {
                
                Text("Skip Now")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        .alert(loginModel.errorMsg, isPresented: $loginModel.showError) {
            
        }
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
