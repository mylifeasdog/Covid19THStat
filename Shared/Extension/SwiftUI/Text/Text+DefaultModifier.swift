//
//  Text+DefaultModifier.swift
//  Text+DefaultModifier
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import SwiftUI

extension View
{
    func defailtModifier(
        alignment: TextAlignment,
        font: Font,
        lineLimit: Int,
        foregroundColor: Color = .white,
        maxHeight: CGFloat? = nil,
        padding: EdgeInsets,
        backgroundColor: Color) -> some View
    {
        return multilineTextAlignment(alignment)
            .font(font)
            .lineLimit(lineLimit)
            .minimumScaleFactor(0.5)
            .foregroundColor(foregroundColor)
            .frame(
                maxWidth: .infinity,
                maxHeight: maxHeight)
            .padding(
                padding)
            .background(backgroundColor)
    }
}
