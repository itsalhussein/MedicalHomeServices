//
// TabsView.swift
//
// Created by Hussein Anwar.
//


import SwiftUI

struct TabsView: View {
    @Binding var tabs: [TabModel]
    @Binding var selectedTab : TabModel
    
    var body: some View {
        if tabs.count > 3 {
            ScrollViewReader { scrollView in
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(alignment: .firstTextBaseline, spacing: 16) {
                        ForEach(tabs.indices, id: \.self) { index in
                            self.tabContent(index:index)
                                .onTapGesture {
                                    updateSelectionState(at: index)
                                    selectedTab = tabs[index]
                                    scrollToItem(scrollView: scrollView, id: index)
                                }
                        }
                    }
                }
            }
            
        } else {
            HStack(alignment: .firstTextBaseline, spacing: 16) {
                ForEach(tabs.indices, id: \.self) { index in
                    self.tabContent(index:index)
                        .onTapGesture {
                            updateSelectionState(at: index)
                            selectedTab = tabs[index]
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func tabContent(index: Int) -> some View {
        return VStack(alignment:.center,spacing:4) {
            Text(LocalizedStringKey(tabs[index].name))
                .currentAppFont(weight: tabs[index].isSelected ? .bold : .medium,size: 15)
                .foregroundStyle( tabs[index].isSelected ? .accent : .textColor)

            if tabs[index].isSelected {
                Rectangle()
                    .frame(height: 4)
                    .foregroundStyle(.accent)
                    .clipShape(.capsule)
            }
        }
        .fixedSize()
    }
    
    private func updateSelectionState(at index: Int) {
        tabs.indices.forEach { i in
            tabs[i].isSelected = (i == index) ? true : false
        }
    }
    
    private func scrollToItem(scrollView: ScrollViewProxy, id: Int) {
        withAnimation {
            print("scrolled =======\n\n to \(id) ")
            scrollView.scrollTo(id, anchor: .bottom)
        }
    }
}

#Preview {
    TabsView(tabs: .constant([TabModel(index:0,
                                   name:"Test short",
                                   isSelected:true),
                              TabModel(index:0,
                                      name:"Test loooong text",
                                       isSelected:false)]),selectedTab: .constant(TabModel()))
}

struct TabModel:Hashable {
    var _id = UUID()
    var index : Int = 0
    var name: String = ""
    var isSelected: Bool = false
    var type:String = ""
    var componentSchemaId: Int = 0
}
