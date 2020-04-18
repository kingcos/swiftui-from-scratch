//
//  FileStorage.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

// 属性包裹，@FileStorage 对外表现的类型为 T
@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory,
         fileName: String) {
        // 初始值为从本地读取的值
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
        
        self.directory = directory
        self.fileName = fileName
    }
    
    var wrappedValue: T? {
        set {
            // 外界设置值时调用
            
            value = newValue
            
            if let value = newValue {
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            } else {
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        
        get { value }
    }
}
