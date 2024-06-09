//
// HomeView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Medical Services")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
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
        }
    }
}

class HomeViewModel : BaseViewModel {
    @Published var medicalServices: [MedicalService] = []
    
    @MainActor
    func getMedicalServices() async {
        state.startLoading()
        do {
            
            let route = APIRouter.MedicalServices
            let response : [MedicalService]?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                medicalServices = response
            }
            error = nil
        } catch {
            self.error = error
            
        }
        state.endLoading()
    }
}

#Preview {
    HomeView()
}
