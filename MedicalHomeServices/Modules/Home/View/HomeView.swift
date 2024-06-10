//
// HomeView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedMedicalService: MedicalService? = nil
    @State private var navigateToNominatedProvidersScreen = false

    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Medical Services")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
                    .padding(.horizontal,16)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.medicalServices) { item in
                            Text(item.name ?? "")
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .padding()
                                .background(Color.init(hexStr: "#1D2F6F"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .shadow(radius: 0.5)
                                .onTapGesture {
                                    selectedMedicalService = item
                                }
                        }
                        
                    }
                    .padding()
                }
            }
            .padding(.horizontal,16)
            .onAppear(perform: {
                Task {
                    await  viewModel.getMedicalServices()
                }
            })
            .sheet(item: $selectedMedicalService) { service in
                MedicalServiceSheet(model: service) { request in
                    selectedMedicalService = nil
                    viewModel.selectedRequest = request
                    navigateToNominatedProvidersScreen.toggle()
                }
                    .presentationDetents([.medium])
            }
            .navigationDestination(isPresented: $navigateToNominatedProvidersScreen) {
                if let requestId = viewModel.selectedRequest?.requestID {
                    RequestNominatedProvidersView(requestId: requestId)
                        .navigationBarBackButtonHidden()
                }
            }
            .overlay {
                if viewModel.state.isLoading {
                    CircleProgressView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
