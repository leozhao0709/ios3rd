//
//  ImagePlayApp.swift
//  ImagePlay
//
//  Created by Lei Zhao on 11/13/20.
//
//

import SwiftUI
import SDWebImageSwiftUI

@main
struct ImagePlayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        // Add multiple caches
        let cache = SDImageCache(namespace: "tiny")
        cache.config.maxMemoryCost = 100 * 1024 * 1024 // 100MB memory
        cache.config.maxDiskSize = 50 * 1024 * 1024 // 50MB disk
        SDImageCachesManager.shared.addCache(cache)
        SDWebImageManager.defaultImageCache = SDImageCachesManager.shared

//    SDImageCachesManager.shared.clear(with: .all, completion: nil)
    }
}
