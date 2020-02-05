//
//  ProfileHost.swift
//  03-App Design and Layout
//
//  Created by kingcos on 2020/2/5.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    @State var draftProfile = Profile.default

    var body: some View {
        Text("Profile for: \(draftProfile.username)")
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
