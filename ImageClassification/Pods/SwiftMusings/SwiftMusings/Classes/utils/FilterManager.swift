//
// Created by Lei Zhao on 11/16/20.
//

import CoreImage.CIFilterBuiltins

@available(macCatalyst 13.0, *)
public class FilterManager {

    public static let shared: FilterManager = FilterManager()

    private init() {
    }

    public func getBuildInCIFilters() -> [String] {
        let properties = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        return properties
    }
}
