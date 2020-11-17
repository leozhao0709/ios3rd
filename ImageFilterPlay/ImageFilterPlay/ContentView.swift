//
//  ContentView.swift
//  ImageFilterPlay
//
//  Created by Lei Zhao on 11/16/20.
//
//

import SwiftUI

struct ContentView: View {
    let image = UIImage(named: "test")!
    var buildInFilters: [String] {
        var filters = FilterManager.sharedInstance.getBuildInCIFilters()
        filters.insert("original", at: 0)
        return filters
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(buildInFilters, id: \.self) { filterName in
                    if filterName == "original" {
                        NavigationLink(destination: Image(uiImage: image).resizable().frame(height: 300)) {
                            Text(filterName)
                        }
                    } else {
                        if let uiImage = image.applyFilter(filter: CIFilter(name: filterName)) {
                            NavigationLink(destination: Image(uiImage: uiImage).resizable().frame(height: 300)) {
                                Text(filterName)
                            }
                        }
                    }
                }
            }
        }
    }
}
