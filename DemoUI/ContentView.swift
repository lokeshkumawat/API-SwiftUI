//
//  ContentView.swift
//  DemoUI
//
//  Created by MR Tailor on 19/10/23.
//

import SwiftUI


struct ContentView: View, SecuredTextFieldParentProtocol {
    var hideKeyboard: (() -> Void)?
    
    @State var userEmail:String = ""
    @State var userPassword:String = ""
    @State private var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                Image("India_jaipur")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color("textColor"), lineWidth: 5))
                
                Text("Login")
                    .foregroundColor(Color("textColor"))
                    .font(Font.system(size: 20))
                
                Spacer()
                CommonTextField(text: $userEmail, hint: "Enter email", keyBoard: .emailAddress)
                Spacer().frame(height: 20)
                SecuredTextFieldView(text: $userPassword, parent: self)
                    .frame(height: 34)
                    .padding(.all,8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("textColor"), lineWidth: 2))
                
                Spacer().frame(height: 20)
                Button(action: {
                    UIApplication.shared.endEditing()
                    if userEmail.isEmpty {
                        alertMessage = "Please enter email"
                        showingAlert.toggle()
                    } else if userPassword.isEmpty {
                        alertMessage = "Please enter password"
                        showingAlert.toggle()
                    } else {
                        
                    }
                    
                }, label: {
                    HStack {
                        Text("SUBMIT")
                            .frame(maxWidth: .infinity)
                            .frame(height: 34)
                    }
                    .foregroundColor(Color("whiteColor"))
                    .cornerRadius(10)
                })
                .buttonStyle(.borderedProminent)
                .tint(Color("textColor"))
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .padding(.all, 24)
            
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }.onAppear(){
            UIApplication.shared.enableKeyBoardManager(true)
        }
        
    }
    
  
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
