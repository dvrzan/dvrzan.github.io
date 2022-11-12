//
//  UIComponents.swift
//  
//
//  Created by Danijela Vrzan on 2022-11-12.
//

import Foundation
import Plot
import Publish


struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}

struct SmallDivider: Component {
    var body: Component {
        Paragraph()
            .class("small-divider")
    }
}

struct MiddleDivider: Component {
    var body: Component {
        Paragraph()
            .class("middle-divider")
    }
}


struct LargeDivider: Component {
    var body: Component {
        Paragraph()
            .class("large-divider")
    }
}
