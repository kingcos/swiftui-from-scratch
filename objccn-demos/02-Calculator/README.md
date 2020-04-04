#  02-Calculator

- @State 和 @Binding：在 View 内部进行状态存储，定义为 private，标记值类型（但后者为引用语义）
- @ObservedObject 修饰的 ObservableObject 变量：跨 View 的状态共享（但需要传递），引用类型，数据变化时通过 @Published 通知 UI 刷新
- @EnvironmentObject 修饰的 ObservableObject 变量：跨 View 状态共享（无需传递），简化代码
