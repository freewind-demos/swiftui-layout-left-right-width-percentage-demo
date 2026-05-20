# SwiftUI 左右 30% / 70% 固定比例布局 Demo

## 简介

这个 Demo 演示一个最简单的 SwiftUI 双栏布局。

左栏永远占窗口宽度的 30%，右栏永远占 70%。窗口 resize 后，两栏宽度会跟着变，但比例不会变。

## 快速开始

### 环境要求

- macOS 14+
- Xcode 15+
- XcodeGen
- fish

### 运行

```bash
cd /Volumes/SN550-2T/freewind-demos/swiftui-layout-left-right-width-percentage-demo

cp -p ~/bin/swift-build.fish ./swift-build.fish
cp -p ~/bin/swift-watch.fish ./swift-watch.fish

./swift-build.fish
```

构建完成后会自动打开 app。若只想验证编译：

```bash
./swift-build.fish --no-open
```

## 注意事项

- 这个 Demo 不是用 `HStack` 的自适应分配去“碰运气”做 30/70
- 它是直接基于窗口当前宽度计算左右栏实际宽度
- 因此窗口怎么拉伸，比例都稳定

## 教程

### 1. 关键概念

目标不是“左边看起来差不多小一点”，而是“左右宽度始终满足固定数学比例”。

这类需求本质是：

1. 先拿到容器当前宽度
2. 再算出左栏宽度
3. 右栏用剩余宽度

在 SwiftUI 里，`GeometryReader` 正适合做这件事。

### 2. Demo 原理

`ContentView` 中先定义比例：

```swift
private let leftRatio: CGFloat = 0.3
```

然后在 `GeometryReader` 里拿到当前窗口内容宽度：

```swift
let leftWidth = proxy.size.width * leftRatio
let rightWidth = proxy.size.width - leftWidth
```

之后把两个 pane 的 `frame(width:)` 显式写死：

```swift
PercentagePane(
    title: "30%",
    background: .blue.opacity(0.8)
)
.frame(width: leftWidth)

PercentagePane(
    title: "70%",
    background: .green.opacity(0.8)
)
.frame(width: rightWidth)
```

这样布局系统每次遇到窗口尺寸变化，都会重新计算宽度，所以比例持续成立。

### 3. 关键代码解读

入口在 [Sources/SwiftUILayoutLeftRightWidthPercentageDemoApp.swift](Sources/SwiftUILayoutLeftRightWidthPercentageDemoApp.swift)。

这里做两件事：

1. 创建主窗口
2. 允许窗口 resize

```swift
Window("30 / 70 Layout", id: "main") {
    ContentView()
}
.defaultSize(width: 900, height: 560)
.windowResizability(.automatic)
```

核心布局在 [Sources/ContentView.swift](Sources/ContentView.swift)。

`PercentagePane` 只是负责展示颜色和中间的百分比文本，本身不决定比例。真正决定比例的是外层 `GeometryReader + frame(width:)`。

这点很重要：展示层只负责展示，宽度计算放在更外层，逻辑更清楚。
