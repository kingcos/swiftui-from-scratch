#  01-Calculator

## @State

```swift
import Foundation

// @State / @Binding / @ObjectBinding / @EnvironmentObject，都是被 @propertyWrapper 修饰的 struct 类型
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper public struct State<Value> : DynamicProperty {

    /// Initialize with the provided initial value.
    public init(wrappedValue value: Value)

    // 当直接赋值给 @State 变量值时，将通过该方法初始化 State
    // initialValue 这个参数名相对特殊：当它出现在 init 方法的第一个参数位置时，编译器将允许我们在声明的时候直接为 @State var brain 进行赋值。
    /// Initialize with the provided initial value.
    public init(initialValue value: Value)

    // 访问和赋值都触发包装的 wrappedValue
    /// The current state value.
    public var wrappedValue: Value { get nonmutating set }

    // 通过 $ 访问的是 projectedValue
    /// Produces the binding referencing this state value
    public var projectedValue: Binding<Value> { get }
}
```
