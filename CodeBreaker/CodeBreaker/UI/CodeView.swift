//
//  CodeView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/19.
//


import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View {
    // MARK: Data In
    let code: Code
    // MARK: Data
    @Binding var selection: Int

    @ViewBuilder
    let ancillaryView: () -> AncillaryView
    // 动画几何匹配namespace
    @Namespace private var bgNamespece
    
    // 函数一定要加 @ViewBuilder,不然编译器识别不了.
    init(code: Code, selection: Binding<Int> = .constant(-1), @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
     
    
    // MARK: - body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background {
                        if code.kind == .guess, selection == index {
                            Selection.shape
                                .foregroundStyle(Selection.color)
//                                .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .bottom)))
                                .matchedGeometryEffect(id: "bg", in: bgNamespece, properties: .position)
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: selection)
                    .overlay(
                        Selection.shape.foregroundStyle(code.isHidden ? Color.gray : Color.clear)
                    )
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView()
                }
        }

    }
    

}
// 泛型不能内部定义结构体或类
// 选择器常量, 集中管理魔法数字
fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadiues: CGFloat = 10
    static let color: Color = Color.gray(brightness: 0.85)
    static let shape = RoundedRectangle(cornerRadius: Selection.cornerRadiues, style: .continuous)
}
