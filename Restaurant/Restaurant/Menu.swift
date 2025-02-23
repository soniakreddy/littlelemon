//
//  Menu.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)], animation: .default)
    private var dishs: FetchedResults<Dish>

    @State private var searchText = ""
    @State private var categoryText = ""

    var body: some View {
        VStack {
            headerView

            Hero()
                .overlay {
                    TextField("Search", text: $searchText)
                        .padding()
                        .padding(.top, 190)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

            Text("ORDER FOR DELIVERY!")
                .bold()
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)

            categoryButtons

            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination: DishDetailView(dish: dish)) {
                            dishRow(for: dish)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            getMenuData()
        }
    }

    private var headerView: some View {
        HStack {
            Image("Logo")
                .padding()
            Image("Profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
    }

    private var categoryButtons: some View {
        HStack {
            Button(action: { categoryText = "starters" }) {
                categoryButtonLabel(text: "Starters")
            }
            Button(action: { categoryText = "mains" }) {
                categoryButtonLabel(text: "Mains")
            }
            Button(action: { categoryText = "desserts" }) {
                categoryButtonLabel(text: "Desserts")
            }
            Button(action: { categoryText = "drinks" }) {
                categoryButtonLabel(text: "Drinks")
            }
        }
        .padding(5)
    }

    private func categoryButtonLabel(text: String) -> some View {
        Text(text)
            .foregroundColor(Color.primaryColor1)
            .font(.callout)
            .padding(15)
            .bold()
            .background(Color.primaryColor2)
            .cornerRadius(20)
    }

    private func dishRow(for dish: Dish) -> some View {
        VStack {
            Text(dish.title ?? "Title")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text(dish.descriptionDish ?? "Description")
                    .font(.callout)
                    .foregroundColor(.gray)
                Spacer()
                AsyncImage(url: URL(string: dish.image ?? "imageURL")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 90, height: 90)
            }
            Text("$" + (dish.price ?? "Price"))
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func getMenuData() {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared

        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let fullMenu = try decoder.decode(MenuList.self, from: data)

                for item in fullMenu.menu {
                    let dish = Dish(context: viewContext)
                    dish.id = Int64(item.id)
                    dish.title = item.title
                    dish.descriptionDish = item.description
                    dish.price = item.price
                    dish.image = item.image
                    dish.category = item.category

                    do {
                        try viewContext.save()
                    } catch {
                        print("Error saving item: \(error)")
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }

    private func buildPredicate() -> NSPredicate {
        if !searchText.isEmpty {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        } else if !categoryText.isEmpty {
            return NSPredicate(format: "category CONTAINS[cd] %@", categoryText)
        }
        return NSPredicate(value: true)
    }

    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
}

#Preview {
    Menu()
}
