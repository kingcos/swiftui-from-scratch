# 04 - Layout

- HStack 接受 VerticalAlignment，典型值为 .top、.center、.bottom、lastTextBaseline 等
- VStack 接受 HorizontalAlignment，典型值为 .leading、.center 和 .trailing
- ZStack 在两个方向上都有对齐的需求，它接受 Alignment
- Alignment 其实就是对 VerticalAlignment 和 HorizontalAlignment 组合的封装
- 默认均为 .center

### VerticalAlignment

VerticalAlignment 是垂直方向上的对齐。

.top 是 VerticalAlignment 中的静态变量：

```swift
extension VerticalAlignment {
    /// A guide marking the top edge of the view.
    public static let top: VerticalAlignment
}
```

VerticalAlignment 接受 AlignmentID 初始化：

```swift
/// An alignment position along the vertical axis.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct VerticalAlignment : Equatable {

    /// Creates an instance with the given identifier.
    ///
    /// Each instance needs a unique identifier.
    ///
    /// - Parameter id: An identifier that uniquely identifies the vertical
    ///   alignment.
    public init(_ id: AlignmentID.Type)
}
```

AlignmentID 协议需要实现一个方法，返回 View 的偏移：

```swift
/// Types used to identify alignment guides.
///
/// Types conforming to `AlignmentID` have a corresponding alignment guide
/// value, typically declared as a static constant property of
/// ``HorizontalAlignment`` or ``VerticalAlignment``.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol AlignmentID {

    /// The value of the corresponding guide in the given context when not
    /// otherwise set in that context.
    static func defaultValue(in context: ViewDimensions) -> CGFloat
}
```

```swift
/// A view's size and its alignment guides in its own coordinate space.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ViewDimensions {

    /// The view's width.
    public var width: CGFloat { get }

    /// The view's height.
    public var height: CGFloat { get }

    // 以下标的方式从 ViewDimensions 获取数据；默认返回 defaultValue 方法的返回值
    /// Gets the value of the given horizontal guide.
    // 获取给定水平参考线的值
    public subscript(guide: HorizontalAlignment) -> CGFloat { get }

    /// Gets the value of the given vertical guide.
    public subscript(guide: VerticalAlignment) -> CGFloat { get }

    // 通过下标获取定义在 View 上的显式对齐值
    /// Gets the explicit value of the given alignment guide in this view, or
    /// `nil` if no such value exists.
    // 获取此视图中给定对齐指南的显式值，如果不存在此类值，则返回 `nil`。
    public subscript(explicit guide: HorizontalAlignment) -> CGFloat? { get }

    /// Gets the explicit value of the given alignment guide in this view, or
    /// `nil` if no such value exists.
    public subscript(explicit guide: VerticalAlignment) -> CGFloat? { get }
}
```

### alignmentGuide

通过 alignmentGuide，我们可以进一步调整 View 在容器 (比如各类 Stack) 中的对齐方式。两个重载方法负责修改水平和垂直的对齐方式，代替原本的 defaultValue(in:) 默认值；
注意：alignmentGuide 中指定的 alignment 必须要和 HStack 这类容 器所指定的 alignment 一致，它才会在布局时被考虑。

```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the view's horizontal alignment.
    ///
    /// Use `alignmentGuide(_:computeValue:)` to calculate specific offsets
    /// to reposition views in relationship to one another. You can return a
    /// constant or can use the ``ViewDimensions`` argument to the closure to
    /// calculate a return value.
    ///
    /// In the example below, the ``HStack`` is offset by a constant of 50
    /// points to the right of center:
    ///
    ///     VStack {
    ///         Text("Today's Weather")
    ///             .font(.title)
    ///             .border(.gray)
    ///         HStack {
    ///             Text("🌧")
    ///             Text("Rain & Thunderstorms")
    ///             Text("⛈")
    ///         }
    ///         .alignmentGuide(HorizontalAlignment.center) { _ in  50 }
    ///         .border(.gray)
    ///     }
    ///     .border(.gray)
    ///
    /// Changing the alignment of one view may have effects on surrounding
    /// views. Here the offset values inside a stack and its contained views is
    /// the difference of their absolute offsets.
    ///
    /// ![A view showing the two emoji offset from a text element using a
    /// horizontal alignment guide.](SwiftUI-View-HAlignmentGuide.png)
    ///
    /// - Parameters:
    ///   - g: A ``HorizontalAlignment`` value at which to base the offset.
    ///   - computeValue: A closure that returns the offset value to apply to
    ///     this view.
    ///
    /// - Returns: A view modified with respect to its horizontal alignment
    ///   according to the computation performed in the method's closure.
    @inlinable public func alignmentGuide(_ g: HorizontalAlignment, computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View


    /// Sets the view's vertical alignment.
    ///
    /// Use `alignmentGuide(_:computeValue:)` to calculate specific offsets
    /// to reposition views in relationship to one another. You can return a
    /// constant or can use the ``ViewDimensions`` argument to the closure to
    /// calculate a return value.
    ///
    /// In the example below, the weather emoji are offset 20 points from the
    /// vertical center of the ``HStack``.
    ///
    ///     VStack {
    ///         Text("Today's Weather")
    ///             .font(.title)
    ///             .border(.gray)
    ///
    ///         HStack {
    ///             Text("🌧")
    ///                 .alignmentGuide(VerticalAlignment.center) { _ in -20 }
    ///                 .border(.gray)
    ///             Text("Rain & Thunderstorms")
    ///                 .border(.gray)
    ///             Text("⛈")
    ///                 .alignmentGuide(VerticalAlignment.center) { _ in 20 }
    ///                 .border(.gray)
    ///         }
    ///     }
    ///
    /// Changing the alignment of one view may have effects on surrounding
    /// views. Here the offset values inside a stack and its contained views is
    /// the difference of their absolute offsets.
    ///
    /// ![A view showing the two emoji offset from a text element using a
    /// vertical alignment guide.](SwiftUI-View-VAlignmentGuide.png)
    ///
    /// - Parameters:
    ///   - g: A ``VerticalAlignment`` value at which to base the offset.
    ///   - computeValue: A closure that returns the offset value to apply to
    ///     this view.
    ///
    /// - Returns: A view modified with respect to its vertical alignment
    ///   according to the computation performed in the method's closure.
    @inlinable public func alignmentGuide(_ g: VerticalAlignment, computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View

}
```
