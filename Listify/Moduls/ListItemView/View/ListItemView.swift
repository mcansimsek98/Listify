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
            let calendar = Calendar.current
            let currentDate = calendar.startOfDay(for: Date())
            let dueDate = Date(timeIntervalSince1970: item.dueDate)
            let dueDateStartOfDay = calendar.startOfDay(for: dueDate)
            
            let isDueDatePassed = dueDateStartOfDay >= currentDate
            Rectangle()
                .fill(isDueDatePassed ? Color.green : Color.red)
                .frame(width: 10)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: 17))
                    .bold()
                    .padding(.top, 8)
                Text(item.body)
                    .font(.system(size: 14))
                    .padding(.bottom, 2)
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .foregroundColor(Color(.secondaryLabel))
                }
                Spacer()
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
        ListItemView(item: .init(id: "", title: "", body: "", dueDate: Date().timeIntervalSince1970, createDate: Date().timeIntervalSince1970, categoryName: "", isDone: false))
    }
}
