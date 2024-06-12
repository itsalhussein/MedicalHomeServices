//
// RequestNominatedProvidersView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct RequestNominatedProvidersView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel : RequestNominatedProvidersViewModel
    @State var showRequestDetails = false
    
    init(requestId:Int) {
        self._viewModel = StateObject(wrappedValue: RequestNominatedProvidersViewModel(requestID: requestId))
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                HStack {
                    Text("Nominated Providers")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                    
                        
                    Spacer()
                    HStack (spacing:16){
                        if let nominatedProviders = viewModel.nominatedProviders ,!nominatedProviders.isEmpty {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 16,height: 16)
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    viewModel.startFetchingNominatedProviders()
                                }
                        }
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16,height: 16)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .padding(.horizontal,16)

                ScrollView {
                    if viewModel.isFetchingProviders {
                        loadingView
                    } else {
                        providersView
                    }
                }
            }
            .onAppear(perform: {
                viewModel.startFetchingNominatedProviders()
            })
            .onDisappear(perform: {
                viewModel.timer = nil
            })
            .onReceive(viewModel.navigateToRequestDetailsSubject, perform: { _ in
                showRequestDetails.toggle()
            })
            .navigationDestination(isPresented: $showRequestDetails) {
                RequestDetailsView(requestId: viewModel.requestID)
                    .navigationBarBackButtonHidden()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    var loadingView : some View {
        return VStack(alignment: .center) {
            Spacer()
                .frame(height: 200)
            LottieView()
                .frame(width:180,height: 180)
            TimerView() {
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
        .padding(.horizontal,24)
    }
    
    var providersView: some View {
        VStack(alignment: .leading) {
            if let providers = viewModel.nominatedProviders {
                ForEach(providers) { provider in
                    VStack {
                        HStack(alignment:.lastTextBaseline){
                            Image("provider")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .shadow(radius: 1)
                                .foregroundStyle(.gray)
                            
                            VStack(alignment:.leading,spacing:8) {
                                Text(provider.fullName ?? "")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .cornerRadius(8)
                                    .padding(.vertical, 4)
                                
                                Text("\(provider.distance?.max2FractionDigits() ?? "0") m away")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .cornerRadius(8)
                                    .padding(.vertical, 4)
                            }
                        }
                        .padding(.top,16)

                        Spacer()
                        CustomButton(title: "Choose Provider",
                                     foregroundColor: .white,
                                     backgroundColor: .green) {
                            //Action for choosing provider
                            if let id = provider.providerID {
                                Task {
                                    await viewModel.addTempProviderToRequest(providerId:id)
                                }
                            }
                        }
                            .frame(height: 50)
                            .padding(.horizontal,48)
                            .padding(.vertical,24)
                    }
                    .background(.gray.opacity(0.2))
                    .cornerRadius(18, corners: .allCorners)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RequestNominatedProvidersView(requestId: 0)
}


