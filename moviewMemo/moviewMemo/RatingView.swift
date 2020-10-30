//
//  RatingView.swift
//  moviewMemo
//
//  Created by Lei Zhao on 10/29/20.
//
//

import SwiftUI

struct RatingView: View {

    @Binding var rating: Int;

    var body: some View {
        HStack {
            ForEach(1..<6, id: \.self) { num in
                Image(systemName: "star.fill")
                    .foregroundColor(self.rating >= num ? Color.yellow : Color.gray)
                    .onTapGesture {
                        self.rating = self.rating == num ? 0 : num
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
