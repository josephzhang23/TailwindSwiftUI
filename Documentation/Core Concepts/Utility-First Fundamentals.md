#  Utility-First Fundamentals

Building complex components from a constrained set of primitive utilities.

---

Traditionally, whenever you need to style something on the SwiftUI, you write view modifiers.

**❌ Using a traditional approach where custom designs require custom values.**

```swift
HStack(spacing: 13) {
    Image("logo")
    VStack(alignment: .leading) {
        Text("ChitChat")
            .font(.system(size: 16.25))
            .lineSpacing(6.5)
            .fontWeight(.medium)
            .foregroundStyle(.black)
        Text("You have a new message!")
            .foregroundStyle(Color(red: 100 / 255, green: 116 / 255, blue: 139 / 255, opacity: 1))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
}
.padding(20)
.frame(maxWidth: 312)
.background(.white)
.clipShape(RoundedRectangle(cornerRadius: 10))
.boxShadow(type: .color(c: .black.opacity(0.1)), radius: 15, offset: .init(x: 0, y: 10), spread: .init(width: -3, height: -3))
.boxShadow(type: .color(c: .black.opacity(0.1)), radius: 6, offset: .init(x: 0, y: 4), spread: .init(width: -4, height: -4))
```

With TailwindSwiftUI, you style elements by applying pre-existing view modifiers directly in your SwiftUI.

**✅ Using utility view modifiers to build custom designs without writing values**

```swift
HStack(spacing: .s4) {
    Image("logo")
    VStack(alignment: .leading) {
        Text("ChitChat")
            .text(.extraLarge)
            .fontWeight(.medium)
            .foregroundStyle(.black)
        Text("You have a new message!")
            .foregroundStyle(.slate500)
    }
    .width(.full, alignment: .leading)
}
.padding(.s6)
.max(width: .small)
.background(.white)
.rounded(.extraLarge)
.shadow(.large)
```