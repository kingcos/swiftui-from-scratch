#  02-Calculator

从 ObservableObject 开始入手会是一个相对好的选择:如果发现状态可以被限制在同一个 View 层级中， 则改用 @State;如果发现状态需要大批量共享，则改用 @EnvironmentObject。
