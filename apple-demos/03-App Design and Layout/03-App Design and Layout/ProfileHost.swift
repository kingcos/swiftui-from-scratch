//
//  ProfileHost.swift
//  03-App Design and Layout
//
//  Created by kingcos on 2020/2/5.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    // 可编辑状态，写入存储
    // 将编辑模式存储在环境中，可以方便地在用户进入和退出编辑模式时更新多个视图。
    @Environment(\.editMode) var mode
    @EnvironmentObject var modelData: ModelData
    @State var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if mode?.wrappedValue == .active {
                    Button("Cancel") {
                        draftProfile = modelData.profile
                        mode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                EditButton()
            }
            
            if mode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        self.draftProfile = self.modelData.profile
                    }
                    .onDisappear {
                        self.modelData.profile = self.draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost().environmentObject(ModelData())
    }
}
