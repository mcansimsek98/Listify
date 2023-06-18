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
    @State private var isDone = false
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: ListVM(userId: userId))
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }
    
    var filteredItemsIsDone: [ListItem] {
        return items.filter {$0.isDone == false }
    }
    
    var filteredItems: [ListItem] {
        let selectedCategory = $viewModel.categories[viewModel.selectedCategoryIndex].wrappedValue
        return viewModel.selectedCategoryIndex == 0 ? items : items.filter {$0.categoryName == selectedCategory.title }
    }
    
    var groupedItems: [String: [ListItem]] {
        Dictionary(grouping: isDone ? filteredItemsIsDone : filteredItems, by: { $0.categoryName })
    }
    
    var sortedGroupedItems: [(key: String, value: [ListItem])] {
        groupedItems.sorted { $0.key < $1.key }
    }
    
    //MARK: VİEW
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
            VStack {
                ListViewBuilder()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct ListItemView_Previews: PreviewProvider {
        static var previews: some View {
            ListView(userId: "")
        }
    }
}

//MARK: ViewBuilder
extension ListView {
    @ViewBuilder
    func ListViewBuilder() -> some View {
        ///Tabbar
        ZStack {
            CustomHeaderView(title: "Listify")
            HStack {
                Spacer()
                Button(action: {
                    self.isDone.toggle()
                }) {
                    Image(systemName: isDone ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                .padding(.trailing, 15)
                .padding(.bottom, -25)
            }
        }
        ///CategoryList View
        ZStack {
            VStack(spacing: 10) {
                HStack(alignment: .bottom) {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [
                            GridItem(.fixed(135))
                        ]) {
                            ForEach(viewModel.categories, id: \.self) { item in
                                Button {
                                    viewModel.selectedCategoryIndex = item.id
                                } label: {
                                    VStack {
                                        ZStack {
                                            Circle().stroke(Color.gray, lineWidth: 2)
                                                .frame(width: 60, height: 60)
                                                .foregroundColor(Color(UIColor.cyan))
                                            
                                            Image(item.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 40, height: 40)
                                        }
                                        Text(LocalizedStringKey(item.title))
                                            .frame(width: 95, height: 20)
                                            .lineLimit(2)
                                            .font(.custom("Marker Felt", size: 14))
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(.black)
                                            .opacity(viewModel.categories[viewModel.selectedCategoryIndex] == item ? 1 : 0)
                                    }
                                    .padding(.top)
                                }
                                
                                .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding(.leading, 5)
                    .scrollIndicators(.never)
                    .frame(height: 90)
                    
                }
                Divider()
                ///Item List View
                if !sortedGroupedItems.isEmpty {
                    List{
                        ForEach(sortedGroupedItems, id: \.key) { key, groupedItems in
                            Section(header: Text(LocalizedStringKey(key))) {
                                ForEach(groupedItems) { item in
                                    ListItemView(item: item)
                                        .swipeActions {
                                            Button(LocalizedStringKey("delete")) {
                                                viewModel.deleteItem(id: item.id)
                                            }
                                            .tint(.red)
                                        }
                                }
                                .listRowBackground(Color(.init(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)))
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                    .scrollIndicators(.never)
                }else {
                    Spacer()
                    VStack {
                        Text(LocalizedStringKey("task_not_found"))
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text(LocalizedStringKey("new_task_question"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 30)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

