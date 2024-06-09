//
//  CustomListView.swift
//  Ekhtesrha
//
//  Created by Hussein Anwar.
//

import SwiftUI


struct CustomListView: View {
    //MARK: - Variables
    @Binding var filterItems: [DropDownData]
    @Binding var selectedFilterItem: DropDownData
    @Binding var hasDynamicHeight : Bool
    var onSelectedFilterItem:(DropDownData?)->Void
    @State private var scrolledToBottom = false
    var isLoadMoreEnabled:(Bool)->Void

    //MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(filterItems.indices, id: \.self) { index in
                    Button(action: {
                        self.updateSelectionState(at: index)
                        selectedFilterItem = filterItems[index]
                        onSelectedFilterItem(selectedFilterItem)
                    }) {
                        HStack {
                            Text(filterItems[index].title)
                                .currentAppFont(weight: .regular, size: 14)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Image(filterItems[index].isSelected ? "ic_selectedFilterItem" : "ic_unselectedFilterItem")
                                .padding(.horizontal,10)
                        }
                        .padding(8)
                        .padding(.horizontal,0)
                        .onAppear {
                            //Handle pagination
                            if index == filterItems.indices.last && filterItems.count > 10 {
                                scrolledToBottom = true
                            }
                        }
                    }
                    .background(Color.white) // Add background color if needed
                    .onTapGesture {
                        print("Item tapped")
                        self.updateSelectionState(at: index)
                        selectedFilterItem = filterItems[index]
                        onSelectedFilterItem(selectedFilterItem)
                        print(#line,selectedFilterItem)
                    }
                    if index != filterItems.indices.last {
                        Divider()
                    }
                }
                .onChange(of: scrolledToBottom) { newValue in
                    if newValue {
                        isLoadMoreEnabled(true)
                        scrolledToBottom = false
                    }
                }
            }
        }
        .frame(height: hasDynamicHeight ? CGFloat(filterItems.count) * 50 : CGFloat(UIScreen.main.bounds.size.height * 0.30))
        .overlay {
            if #available(iOS 17.0, *) {
            UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 11, bottomTrailing: 11))
                .fill(Color.clear)
                .stroke(Color.init(hex: 0xD6D6F9),lineWidth: 0.3)
            } else {
                    // Fallback on earlier versions
            }
        }
    }
    
    private func updateSelectionState(at index: Int) {
        filterItems.indices.forEach { i in
            filterItems[i].isSelected = (i == index) ? true : false
        }
    }
}

#Preview {
    CustomListView(filterItems: .constant([
        DropDownData(id:0,title:"كلام",isSelected: false),
        DropDownData(id:0,title:"عربي",isSelected: false)
    ])
                   ,selectedFilterItem: .constant(.init(id: 0)),
                   hasDynamicHeight: .constant(true),
                   onSelectedFilterItem: { _ in
        
    }, isLoadMoreEnabled: { _ in
        
    })
        .environment(\.locale, AppSettings.shared.local)
        .environment(\.layoutDirection, AppSettings.shared.layoutDirection)
}
