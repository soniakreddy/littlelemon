//
//  Home.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared

    var body: some View {
        TabView {
            Menu()
                .font(.title)
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            UserProfile()
                .font(.title)
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
