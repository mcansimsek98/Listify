//
//  ToDoListItemView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct ListItemView: View {
    @StateObject var viewModel = ListItemVM()
    let item: ListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button {
                viewModel.toogleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.teal)
            }
        }
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(item: .init(id: "", title: "", dueDate: Date().timeIntervalSince1970, createDate: Date().timeIntervalSince1970, categoryName: "", isDone: false))
    }
}
