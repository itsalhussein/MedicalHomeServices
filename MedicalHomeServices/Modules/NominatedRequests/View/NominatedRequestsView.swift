//
// NominatedRequestsView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct NominatedRequestsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel = NominatedRequestsViewModel()
    @State var showRequestDetails = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                HStack {
                    Text("Requests")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                    
                        
                    Spacer()
                    HStack (spacing:16){
                      
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .frame(width: 16,height: 16)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                Task {
                                    await viewModel.fetchNominatedRequests()
                                }
                            }
                    }
                }
                .padding(.horizontal,16)

                ScrollView {
                    if !viewModel.hasRequests {
                        Spacer()
                            .frame(height: 240)
                        Text("You don't have any requests yet.")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .cornerRadius(8)
                            .padding(.horizontal,48)
                        Spacer()
                    } else {
                        requestsView
                    }
                }
            }
            .onAppear(perform: {
                Task {
                    await viewModel.updateProviderLocation()
                    await viewModel.fetchNominatedRequests()
                }
            })
            .navigationDestination(isPresented: $showRequestDetails) {
                if let id = viewModel.selectedRequestId {
                    RequestDetailsView(requestId: id,isProvider: true)
                }
            }
        }
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
    
    var requestsView: some View {
        VStack(alignment: .leading) {
            if let requests = viewModel.requests {
                ForEach(requests) { request in
                    VStack {
                        HStack(alignment:.center){
                            Image("customer")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .shadow(radius: 1)
                                .foregroundStyle(.gray)
                            
                            VStack(alignment:.leading,spacing:8) {
                                Text(request.userFullName ?? "")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .cornerRadius(8)
                                    .padding(.vertical, 4)
                            }
                        }
                        .padding(.top,16)

                        Spacer()
                        HStack {
                            CustomButton(title: "Accept",
                                         foregroundColor: .white,
                                         backgroundColor: .green) {
                                //Action for accept
                                if let id = request.requestID {
                                    let requestStatus = UpdateRequestStatus(requestID: id, userID: AppSettings.shared.currentUser?.userID, status: 1)
                                    Task {
                                        await Helper.updateRequestStatus(requestStatus:requestStatus) { _ in
                                            viewModel.selectedRequestId = id
                                            showRequestDetails.toggle()
                                        }
                                    }
                                }
                            }
                                         .frame(width:160,height: 50)
//                                .padding(.horizontal,48)
//                                .padding(.vertical,24)
                            
                            CustomButton(title: "Reject",
                                         foregroundColor: .white,
                                         backgroundColor: .red) {
                                //Action for accept
                                if let id = request.requestID {
                                    let requestStatus = UpdateRequestStatus(requestID: id, userID: AppSettings.shared.currentUser?.userID, status: 0)
                                    Task {
                                        await Helper.updateRequestStatus(requestStatus:requestStatus) { _ in
                                            Task {
                                                await viewModel.fetchNominatedRequests()
                                            }
                                        }
                                    }
                                }
                            }
                                .frame(width:160,height: 50)
//                                .padding(.horizontal,48)
//                                .padding(.vertical,24)
                        }
                        .padding(.vertical)
                       
                    }
                    .padding(.horizontal,16)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(18, corners: .allCorners)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NominatedRequestsView()
}


