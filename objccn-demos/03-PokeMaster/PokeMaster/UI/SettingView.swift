//
//  SettingView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct SettingView: View {
//    @ObservedObject var settings = Settings()
    
    // 需注入
    @EnvironmentObject var store: Store
    // 包装为计算属性
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if settings.loginUser == nil {
                // 未登录时，仅显示登录和注册表单
                
                Picker(selection: settingsBinding.accountBehavior,
                       label: Text("")) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // Segment 样式
                TextField("电子邮箱", text: settingsBinding.email)
                SecureField("密码", text: settingsBinding.password) // 安全键盘
                
                if settings.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.verifyPassword)
                }
                
                Button(settings.accountBehavior.text) {
                    print("登录/注册")
                }
                
            } else {
                // 已登录时，显示邮箱 & 注销
                
                Text(settings.loginUser!.email)
                Button("注销") {
                    print("注销")
                }
                
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")) {
//            Toggle(isOn: $settings.showEnglishName) {
            Toggle(isOn: settingsBinding.showEnglishName) {
                Text("显示英文名")
            }
            Picker(
//                selection: $settings.sorting,
                selection: settingsBinding.sorting,
                label: Text("排序方式")
            ) {
                ForEach(Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
//            Toggle(isOn: $settings.showFavoriteOnly) {
            Toggle(isOn: settingsBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
        }
    }

    var actionSection: some View {
        Section {
            Button(action: {
                print("清空缓存")
            }) {
                Text("清空缓存").foregroundColor(.red)
            }
        }
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
    }
}

extension AppState.Settings.Sorting {
    var text: String {
        switch self {
            case .id: return "ID"
            case .name: return "名字"
            case .color: return "颜色"
            case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
            case .register: return "注册"
            case .login: return "登录"
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        store.appState.settings.sorting = .color
        return SettingView().environmentObject(store)
    }
}
