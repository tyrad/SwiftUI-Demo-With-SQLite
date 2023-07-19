//
//  BikeRadioButton.swift
//  SwiftUIWithSqlite
//
//  Created by mist on 2023/7/19.
//

import SwiftUI

struct BikingStartButton: View {
    var body: some View {
        Image(systemName: "bicycle")
            .resizable()
            .scaledToFill()
            .frame(width: 25, height: 25)
            .foregroundColor(.white)
            .padding(20)
            .background(Color.accentColor)
            // 设置为圆角
            // 这种设置在创建按钮、卡片、标签等圆形或圆角视图时很有用。通常情况下，我们可以设置一个固定的半径来产生具有一定角度的圆角效果，但是当我们想要完全没有角度时，就需要将半径设置为无限大，即 cornerRadius(.infinity)。这样的设置可以使一个矩形视图变为一个完全圆形的视图，或使视图的四个角完全变为圆形，没有任何锐角。
            .cornerRadius(.infinity)
    }
}

struct BikeRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        BikingStartButton()
    }
}
