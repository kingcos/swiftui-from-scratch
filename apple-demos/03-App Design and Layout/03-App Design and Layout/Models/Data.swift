//
//  Data.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import UIKit
import SwiftUI

let sceneData: [Scene] = load("sampleData.json")
let hikeData: [Hike] = load("hikeData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else { fatalError() }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError()
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError()
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String : CGImage]
    fileprivate var images: _ImageDictionary = [:]
    
    fileprivate static var scale = 2
    
    // 单例模式
    static var shared = ImageStore()
    
    /// 根据图片名构造 Image 控件
    /// - Parameter name: 图片名
    func image(name: String) -> Image {
        // 获取图片索引
        let index = _guaranteeImage(name: name)
        
        // 返回构造好的 Image 控件
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }
    
    /// 根据图片名加载 CGImage
    /// - Parameter name: 图片名
    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
            else { fatalError() }
        
        return image
    }
    
    /// 根据图片名保证返回索引
    /// - Parameter name: 图片索引
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        // 尝试获取
        if let index = images.index(forKey: name) { return index }
        
        // 获取不到则去加载并构造 images 字典
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

