//
//  Hero.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack(alignment: .leading) {

            Text("Little Lemon")
                .font(.largeTitle)
                .foregroundColor(Color.primaryColor2)

            Text("Chicago")
                .font(.title2)
                .foregroundColor(.white)

            HStack {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.callout)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                Image("Hero image")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(15)
        .padding(.bottom, 50)
        .background(Color.primaryColor1)

    }
}

#Preview {
    Hero()
}
