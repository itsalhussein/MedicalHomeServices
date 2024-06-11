//
// DatePickerSheet.swift
//
// Created by Hussein Anwar.
//


import SwiftUI

struct DatePickerSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var date:Date = .now
    var onDone:(Date)->Void

    var body: some View {
        
        VStack{
            
            headerView
            
            contentView
            
            Spacer()
        }
        .padding()
        .environment(\.locale, AppSettings.shared.local)
        .environment(\.layoutDirection, AppSettings.shared.layoutDirection)
    }
    
    private var headerView :some View{
        
        return HStack{
           
//            Button(action: {
//                dismiss()
//            }) {
//                Image("ic_back_arrow")
//                    .renderingMode(.template)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 8,height: 8,alignment: .center)
//            } //: BUTTON
//            .frame(width: 22,height: 22)
//            .foregroundColor(Color.primaryColor)
//            .background(Color(hex:0xAEAEF4,alpha: 0.2))
//            .clipShape(Circle())
            
            Text("Choose Your Birth Date")
                .currentAppFont(weight: .bold, size: 14)
                .foregroundStyle(Color.primaryColor)
            
            Spacer()
            
            Button(action: {
                onDone(date)
            }) {
                Text("Done")
                    .currentAppFont(weight: .bold, size: 14)
                    .foregroundStyle(Color.primaryColor)
            } //: BUTTON
            
        }
    }
    
    private var contentView : some View{
        
        @State var birthDate:Date = .now

        return ZStack(alignment: .center){
            
            DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date,label: {})
                .datePickerStyle(.wheel)
            
        }
    }
}

#Preview {
    DatePickerSheet(date: .now, onDone: {date in})
    .environment(\.locale, AppSettings.shared.local)
    .environment(\.layoutDirection, AppSettings.shared.layoutDirection)
}
