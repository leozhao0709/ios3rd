//
// Created by Lei Zhao on 11/16/20.
//

import CoreImage.CIFilterBuiltins

public class FilterManager {

    public static let sharedInstance: FilterManager = FilterManager()

    private init() {
    }

    public func getBuildInCIFilters() -> [String] {
        let properties = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        return properties
    }
}
