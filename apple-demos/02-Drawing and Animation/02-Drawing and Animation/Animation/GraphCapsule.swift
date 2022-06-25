/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A single line in the graph.
 */

import SwiftUI

struct GraphCapsule: View {
    var index: Int
    var color: Color
    var height: CGFloat
    var range: Range<Double>
    var overallRange: Range<Double>
    
    // 高度比例
    var heightRatio: CGFloat {
        max(CGFloat(magnitude(of: range) / magnitude(of: overallRange)), 0.15)
    }
    
    // 偏移比例（差值越大，偏移越大）
    var offsetRatio: CGFloat {
        CGFloat((range.lowerBound - overallRange.lowerBound) / magnitude(of: overallRange))
    }
    
    var animation: Animation {
        // Animation.default
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
    
    var body: some View {
        Capsule()
            .fill(color)
            .frame(height: height * heightRatio, alignment: .bottom)
            .offset(x: 0, y: height * -offsetRatio)
            .animation(animation)
    }
}

struct GraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        GraphCapsule(index: 0, color: .red, height: 150, range: 10..<50, overallRange: 0..<100)
    }
}
