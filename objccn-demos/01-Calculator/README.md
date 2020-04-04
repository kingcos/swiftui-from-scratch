#  01-Calculator

## Redux

Redux (状态管理和组件通讯架构)

1. 将 app 当作一个状态机，状态决定用户界面；
2. 这些状态都保存在一个 Store 对象中，被称为 State；
3. View 不能直接操作 State，而只能通过发送 Action 的方式，间接改变存储在 Store 中的 State；
4. Reducer 接受原有的 State 和发送过来的 Action，生成新的 State；
5. 用新的 State 替换 Store 中原有的状态，并用新状态来驱动更新界面。

## propertyWrapper

`@State / @Binding / @ObjectBinding / @EnvironmentObject`，都是被  `@propertyWrapper`  修饰的 struct 类型：

```swift
/// A linked View property that instantiates a persistent state
/// value of type `Value`, allowing the view to read and update its
/// value.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen @propertyWrapper public struct State<Value> : DynamicProperty {

    // 初始化（两个初始化方法的意义？）
    /// Initialize with the provided initial value.
    public init(wrappedValue value: Value)

    /// Initialize with the provided initial value.
    public init(initialValue value: Value)
    
    // 外界访问和赋值都触发包装的 wrappedValue
    /// The current state value.
    public var wrappedValue: Value { get nonmutating set }
    
    // 通过 $ 访问的是 projectedValue，但这里暴露的是引用语义
    //（之前 State 通过遵守 BindingConvertible，State 暴露修改内部存储的方法）
    /// Produces the binding referencing this state value
    public var projectedValue: Binding<Value> { get }
}
```

适用于依赖 getter & setter 的方式：比如通过属性对 UserDefaults 或者 Keychain 进行读写、对某个字符串进行格式化或者去前后段空白、为属性读写加锁等等
