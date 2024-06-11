//
// SwitchToProviderSheet.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI
import Combine

struct SwitchToProviderSheet: View {
    @StateObject var viewModel = SwitchToProviderSheetViewModel()
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 24)
            Text("Please select services that you would like to provide:")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
            ScrollView  {
               LazyVGrid(columns: [GridItem(.adaptive(minimum: 110, maximum: 180), spacing: 10)], spacing: 10) {
                    ForEach(viewModel.medicalServices) { service in
                        TagView(service: service,
                                isSelected: isSelected(service:service))
                        .onTapGesture {
                            toggleSelection(service: service)
                            print("viewModel.selectedServices == \n",viewModel.selectedServices)
                        }
                    }
                }
                .padding()
            }
            CustomButton(title: "Switch to Provider",
                         foregroundColor: .white,
                         backgroundColor: .accent) {
                Task {
                    await viewModel.switchToProvider()
                }
                
            }
            .padding(.horizontal,16)
        }
        .padding(.horizontal,16)
        .onAppear(perform: {
            Task {
                await viewModel.getMedicalServices()
                await viewModel.getUserServices()
            }
        })
        .onReceive(viewModel.successSubject, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
    
    private func isSelected(service: MedicalService) -> Bool {
        viewModel.selectedServices.contains { $0 == service }
    }
    
    private func toggleSelection(service: MedicalService) {
        if let index = viewModel.selectedServices.firstIndex(where: { $0 == service }) {
            viewModel.selectedServices.remove(at: index)
        } else {
            viewModel.selectedServices.append(service)
        }
    }
}


struct TagView: View {
    let service: MedicalService
    let isSelected: Bool
    
    var body: some View {
        Text(service.name ?? "")
            .padding(10)
            .background(isSelected ? Color.green.opacity(0.3) : Color.gray.opacity(0.2))
            .cornerRadius(8)
            .foregroundColor(isSelected ? .black : .gray)
    }
}



#Preview {
    SwitchToProviderSheet()
}
