//
//  DishDetailView.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//

import SwiftUI

struct DishDetailView: View {
    let dish: Dish

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300) 
            } placeholder: {
                Color.gray
            }
            .padding()

            Text(dish.title ?? "Unknown Name")
                .font(.largeTitle)
                .padding()

            Text("Price: \(dish.price ?? "0")$")
                .font(.headline)
                .padding()

            Text(dish.descriptionDish ?? "No description available.")
                .font(.body)
                .foregroundColor(.gray)
                .padding()

            Spacer()

            Button(action: {
                print("Added \(dish.title ?? "Unknown") for \(dish.price ?? "0")$")
            }) {
                Text("Add for \(dish.price ?? "0")$")
                    .foregroundColor(Color.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.black)
            .cornerRadius(8)
            .padding()

            Spacer()
        }
        .navigationTitle("Dish Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
