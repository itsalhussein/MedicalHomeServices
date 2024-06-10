//
// RequestNominatedProvidersView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct RequestNominatedProvidersView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel : RequestNominatedProvidersViewModel
    
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
                                presentationMode.wrappedValue.dismiss()
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
                    HStack {
                        Image("provider")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .padding(.top, 50)
                            .foregroundStyle(.gray)
                        
                        Text(provider.name ?? "")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.vertical, 4)
                    }
                    
                    Spacer()
                    
                    CustomButton(title: "Accept",
                                 foregroundColor: .white,
                                 backgroundColor: .green) {
                        //Action for accept
                        
                    }
                        .frame(width: 80)
                    
                    CustomButton(title: "Reject",
                                 foregroundColor: .white,
                                 backgroundColor: .red) {
                        //Action for Reject

                        
                    }
                        .frame(width: 80)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RequestNominatedProvidersView(requestId: 0)
}


