//
//  DatePickerString.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 13.06.2023.
//

import SwiftUI


struct DatePickerStringView: View {
    @Binding var birthday: String
    
    var body: some View {
        HStack {
            DatePicker(selection: Binding<Date>(
                get: {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    if let birthdayDate = dateFormatter.date(from: birthday) {
                        return birthdayDate
                    } else {
                        return Date()
                    }
                },
                set: { newDate in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    birthday = dateFormatter.string(from: newDate)
                }
            ), in: ...Date(), displayedComponents: .date) {
                Text(LocalizedStringKey("birthday"))
                    .bold()
            }
            .datePickerStyle(CompactDatePickerStyle())
            .onAppear {
                if birthday.isEmpty {
                    birthday = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
                }
            }
        }
    }
}
