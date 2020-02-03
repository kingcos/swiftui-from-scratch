//
//  Settings.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct Settings : View {
    @State var receive = true
    @State var number = 1
    @State var selection = 1
    @State var date = Date()
    @State var email = ""
    @State var submit = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $receive) {
                    Text("Receive notifications")
                }
                
                Stepper(value: $number, in: 1...10) {
                    Text("\(number) Notification\(number > 1 ? "s": "") per week")
                }
                
                Picker(selection: $selection,
                       label: Text("Favorite course")) {
                        Text("SwiftUI").tag(1)
                        Text("React").tag(2)
                }
                
                DatePicker(selection: $date) {
                    Text("Date")
                }
                
                
                Section(header: Text("Email")) {
                    TextField("Your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.emailAddress)
                }
                
                Button(action: { self.submit.toggle() }) {
                    Text("Submit")
                }
//                .alert(isPresented: $submit) {
//                    Alert(title: Text("Thanks!"),
//                          message: Text("Email: \(email)"))
//                }
                
                if submit {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(receive ? "Subscribed": "Not subscribed")
                        Text("Emails: \(email)")
                        Text("Favorite: \(selection)")
                        Text("Date: \(date)")
                        Text("email: \(email)")
                    }.padding()
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
