//
// MedicalServiceSheet.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI
import Combine

struct MedicalServiceSheet: View {
    let viewModel = MedicalServiceSheetViewModel()
    var model: MedicalService
    var navigateToNomintedProvidersView : ((ServiceRequestModel)->Void)?
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Text("Service name")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Text(model.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()

                CustomButton(title: viewModel.state.isLoading ? "" : "Request Service",
                             foregroundColor: .white,
                             backgroundColor: .accent) {
                    Task {
                        if let id = model.id {
                            await viewModel.requestService(serviceId:id)
                        }
                    }
                }
                             .padding(.horizontal,24)
                             .buttonStyle(LoadingButtonStyle(isLoading: viewModel.state.isLoading, color: .clear))
            }
            .onReceive(viewModel.successSubject, perform: { response in
                navigateToNomintedProvidersView?(response)
            })
        }
    }
}

#Preview {
    MedicalServiceSheet(model: .init(name:"xray"))
}
