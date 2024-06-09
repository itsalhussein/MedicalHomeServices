//
// CustomDropDownMenuView.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import SwiftUI

struct CustomDropDownMenuView: View {
    //MARK: - Variables
    var title:String
    var selectedId:Int? = nil
    var onSelectedFilterItem:(DropDownData?)->Void
    @Binding var values:[DropDownData]
    @State private var originalValues: [DropDownData] = []
    var titleSize:CGFloat = 14
    var titleColor:Color = Color.primaryColor
    @Binding var expanded : Bool
    @State private var rotationAngle: Double = 0
    @State var selectedFilterItem: DropDownData
    @State var hasDynamicHeight : Bool = true
    
    //MARK: - Body
    var body: some View {
        
        VStack(alignment: .leading,spacing: 0) {
            
            MenuItemView(title: title, expanded: expanded) {
                withAnimation {
                    print(#line,selectedFilterItem)
//                    onSelectedID(selectedItemId)
                    updateFilterItems()
                    expanded.toggle()
                    hasDynamicHeight = values.count < 8
                }
            }
            
            if expanded {
                CustomListView(filterItems: $values,
                               selectedFilterItem: $selectedFilterItem,
                               hasDynamicHeight: $hasDynamicHeight,
                               onSelectedFilterItem: handleSelectedFilterItem) { _ in
                    
                }
            }
        }
        .onAppear(perform: {
            originalValues = values
        })
        .padding(.horizontal)
        
        
    }
    
    func handleSelectedFilterItem(_ item: DropDownData?) {
        onSelectedFilterItem(item)
    }
    
    func updateFilterItems(){
        values.indices.forEach { index in
            values[index].isSelected = values[index].id == selectedId
        }
    }

    @ViewBuilder
    private func MenuItemView(title:String,
                              icon:String = "",
                              color:Color = Color.textColor,
                              expanded:Bool = false,
                              onClick:@escaping ()->Void) -> some View {
        
        
        Button {
            onClick()
           
        } label: {
            
            HStack(spacing: 16){
                
                HStack{
                    if !icon.isEmpty{
                        Image(icon)
                        //.scaledToFit()
                    }
                    
                    Text(LocalizedStringKey(title))
                        .currentAppFont(weight: .medium,size: 14)
                        .foregroundStyle(color)
                    
                }
                .animation(nil,value: 1.0)
                
                Spacer()
        
                Image("ic_down_arrow")
                    .rotationEffect(Angle(degrees: rotationAngle))
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical,12)
            .background(Color.clear)
            .onChange(of: expanded) { newValue in
                
                withAnimation(.easeInOut(duration: 0.2)) {
                    rotationAngle += 180
                }
                rotationAngle = newValue ? 180 : 0

            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            }
            //            .background(
            //                RoundedRectangle(cornerSize: 11)
            //                    .fill(Color(hex: 0xEFEFFD,alpha: 0.5))
            //                    //.shadow(color: Color(hex: 0x4949E7, alpha: 0.16), radius: 8, x: 0, y: 0)
            //            )
        }
    }
}



#Preview {
    CustomDropDownMenuView(
        title: "الماركة",
        selectedId : 1,
        onSelectedFilterItem: { _ in
            
        },
        values: .constant([
            DropDownData(id:1, title: "1"),
            DropDownData(id:2, title: "2"),
            DropDownData(id:3, title: "3"),
            DropDownData(id:4, title: "4"),
            DropDownData(id:5, title: "5"),
            DropDownData(id:6, title: "6")
        ]),
        expanded: .constant(false),
        selectedFilterItem: .init(id: 0)
    )
    .environment(\.locale, AppSettings.shared.local)
    .environment(\.layoutDirection, AppSettings.shared.layoutDirection)
}

