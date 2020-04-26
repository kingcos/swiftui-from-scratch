# 03 - PokeMasterr

## Publisher

- 框架自带的 Publisher 具体类型大部分定义在 Publishers 枚举中：

```swift
/// A namespace for types related to the Publisher protocol.
///
/// The various operators defined as extensions on `Publisher` implement their functionality as classes or structures that extend this enumeration. For example, the `contains()` operator returns a `Publishers.Contains` instance.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public enum Publishers {
}
```

- Publisher 协议：
- output*(failure|finished)?

```swift
/// Declares that a type can transmit a sequence of values over time.
///
/// There are four kinds of messages:
///     subscription - A connection between `Publisher` and `Subscriber`.
///     value - An element in the sequence.
///     error - The sequence ended with an error (`.failure(e)`).
///     complete - The sequence ended successfully (`.finished`).
///
/// Both `.failure` and `.finished` are terminal messages.
///
/// You can summarize these possibilities with a regular expression:
///   value*(error|finished)?
///
/// Every `Publisher` must adhere to this contract.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol Publisher {

    /// 发出的值的类型
    /// The kind of values published by this publisher.
    associatedtype Output

    /// 发出的错误的类型
    /// The kind of errors this publisher might publish.
    ///
    /// Use `Never` if this `Publisher` does not publish errors.
    associatedtype Failure : Error

    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
    ///
    /// - SeeAlso: `subscribe(_:)`
    /// - Parameters:
    ///     - subscriber: The subscriber to attach to this `Publisher`.
    ///                   once attached it can begin to receive values.
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Subscribers {

    /// 错误和完成事件均使用 Completion 描述：
    /// A signal that a publisher doesn’t produce additional elements, either due to normal completion or an error.
    ///
    /// - finished: The publisher finished normally.
    /// - failure: The publisher stopped publishing due to the indicated error.
    @frozen public enum Completion<Failure> where Failure : Error {

        case finished

        case failure(Failure)
    }
}
```

## Subscriber

```swift
/// A namespace for types related to the `Subscriber` protocol.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public enum Subscribers {
}

/// A protocol that declares a type that can receive input from a publisher.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol Subscriber : CustomCombineIdentifierConvertible {

    /// 接收的值的类型
    /// The kind of values this subscriber receives.
    associatedtype Input

    /// 接收的错误的类型
    /// The kind of errors this subscriber might receive.
    ///
    /// Use `Never` if this `Subscriber` cannot receive errors.
    associatedtype Failure : Error

    /// Tells the subscriber that it has successfully subscribed to the publisher and may request items.
    ///
    /// Use the received `Subscription` to request items from the publisher.
    /// - Parameter subscription: A subscription that represents the connection between publisher and subscriber.
    func receive(subscription: Subscription)

    /// Tells the subscriber that the publisher has produced an element.
    ///
    /// - Parameter input: The published element.
    /// - Returns: A `Demand` instance indicating how many more elements the subcriber expects to receive.
    func receive(_ input: Self.Input) -> Subscribers.Demand

    /// Tells the subscriber that the publisher has completed publishing, either normally or with an error.
    ///
    /// - Parameter completion: A `Completion` case indicating whether publishing completed normally or with an error.
    func receive(completion: Subscribers.Completion<Self.Failure>)
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {

    /// Attaches a subscriber with closure-based behavior.
    ///
    /// This method creates the subscriber and immediately requests an unlimited number of values, prior to returning the subscriber.
    /// - parameter receiveComplete: The closure to execute on completion.
    /// - parameter receiveValue: The closure to execute on receipt of a value.
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    public func sink(
        // 完成事件
        // Self 发布结束事件后调用
        receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void), 
        // 值事件
        // Self 发布值事件后调用
        receiveValue: @escaping ((Self.Output) -> Void)
    ) -> AnyCancellable
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher where Self.Failure == Never {

    /// Assigns each element from a Publisher to a property on an object.
    ///
    /// - Parameters:
    ///   - keyPath: The key path of the property to assign.
    ///   - object: The object on which to assign the value.
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    public func assign<Root>(
        // public class ReferenceWritableKeyPath<Root, Value> : WritableKeyPath<Root, Value>
        // keyPath 需为 ReferenceWritableKeyPath 类型，因此只有 class 的属性可被绑定
        // 且常用于 protocol ObservableObject : AnyObject，也只能是 class 类型（继承自 AnyObject，https://kingcos.me/posts/2019/type_introspection_and_reflection/）
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, 
        on object: Root
    ) -> AnyCancellable
}
```

## Subject

```swift
/// A publisher that exposes a method for outside callers to publish elements.
///
/// A subject is a publisher that you can use to ”inject” values into a stream, by calling its `send()` method. This can be useful for adapting existing imperative code to the Combine model.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol Subject : AnyObject, Publisher {

    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    func send(_ value: Self.Output)

    /// Sends a completion signal to the subscriber.
    ///
    /// - Parameter completion: A `Completion` instance which indicates whether publishing has finished normally or failed with an error.
    func send(completion: Subscribers.Completion<Self.Failure>)

    /// Provides this Subject an opportunity to establish demand for any new upstream subscriptions (say via, ```Publisher.subscribe<S: Subject>(_: Subject)`
    func send(subscription: Subscription)
}
```

## Cancellable & AnyCancellable

```swift
// 如果没有持有则会释放并 cancel
// let anyCancellableTimer: AnyCancellable
let anyCancellableTimer = Timer.publish(every: 1, on: .main, in: .default)
    .sink(
        receiveCompletion: { _ in },
        receiveValue: { _ in }
    )

//let cancellableTimer: Cancellable
let cancellableTimer = Timer.publish(every: 1, on: .main, in: .default)
    .connect()
// 必须主动调用 cancel 来释放
cancellableTimer.cancel()
```

### Cancellable

- 需要主动显式调用 `cancel()`
- 也可包装在 `AnyCancellable` 中

```swift
// 协议
/// A protocol indicating that an activity or action may be canceled.
///
/// Calling `cancel()` frees up any allocated resources. It also stops side effects such as timers, network access, or disk I/O.
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol Cancellable {

    /// Cancel the activity.
    func cancel()
}
```

### AnyCancellable

- `deinit` 时自动调用 `cancel()`
- 也可主动调用 `cancel()` 提前释放

```swift
// 类（可自身对生命周期进行管理）
/// A type-erasing cancellable object that executes a provided closure when canceled.
///
/// Subscriber implementations can use this type to provide a “cancellation token” that makes it possible for a caller to cancel a publisher, but not to use the `Subscription` object to request items.
/// An AnyCancellable instance automatically calls `cancel()` when deinitialized. ⬅️
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final public class AnyCancellable : Cancellable, Hashable {
    // ...
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Subscribers {
    // 起初 sink 方法返回的是 Subscribers.Sink，但只满足 Cancellable，因此需要手动调用 cancel()
    // 但现在包装成了 AnyCancellable
    /// A simple subscriber that requests an unlimited number of values upon subscription.
    final public class Sink<Input, Failure> : Subscriber, Cancellable, CustomStringConvertible, CustomReflectable, CustomPlaygroundDisplayConvertible where Failure : Error {
        // ...
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {

    /// Attaches a subscriber with closure-based behavior.
    ///
    /// This method creates the subscriber and immediately requests an unlimited number of values, prior to returning the subscriber.
    /// - parameter receiveComplete: The closure to execute on completion.
    /// - parameter receiveValue: The closure to execute on receipt of a value.
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    public func sink(receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void), receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable
}
```

## 布局与对齐

### 布局流程

- 协商解决，层层上报

### 布局优先级

- 布局优先级默认为 0，但可以通过 `.layoutPriority(1)` 修改为更高优先级。

### 强制固定尺寸

- `fixedSize` 后使用 `frame`

### Stack View 的对齐

```swift
@frozen public struct VerticalAlignment : Equatable {

    /// Creates an instance with the given ID.
    ///
    /// Note: each instance should have a unique ID.
    public init(_ id: AlignmentID.Type)
}

extension VerticalAlignment {

    /// A guide marking the top edge of the view.
    public static let top: VerticalAlignment

    // ...
}

public protocol AlignmentID {

    // 使用对齐方式时的偏移量
    /// Returns the value of the corresponding guide, in `context`, when not
    /// otherwise set in `context`.
    static func defaultValue(in context: ViewDimensions) -> CGFloat
}

// 根据 context 即 ViewDimensions 获取
public struct ViewDimensions {
    // 视图宽高
    
    /// The view's width
    public var width: CGFloat { get }

    /// The view's height
    public var height: CGFloat { get }

    /// Accesses the value of the given guide.
    public subscript(guide: HorizontalAlignment) -> CGFloat { get }

    /// Accesses the value of the given guide.
    public subscript(guide: VerticalAlignment) -> CGFloat { get }

    // 显式对齐值
    /// Returns the explicit value of the given alignment guide in this view, or
    /// `nil` if no such value exists.
    public subscript(explicit guide: HorizontalAlignment) -> CGFloat? { get }

    /// Returns the explicit value of the given alignment guide in this view, or
    /// `nil` if no such value exists.
    public subscript(explicit guide: VerticalAlignment) -> CGFloat? { get }
}
```

```swift
extension VerticalAlignment {
    struct MyCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height / 2
        }
    }
    
    static let myCenter = VerticalAlignment(MyCenter.self)
}
````
