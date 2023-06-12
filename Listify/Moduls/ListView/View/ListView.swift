//
//  ListItemView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ListView: View {
    @StateObject var viewModel: ListVM
    @FirestoreQuery var items: [ListItem]
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: ListVM(userId: userId))
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.deleteItem(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Listify")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                CreateNewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(userId: "")
    }
}
