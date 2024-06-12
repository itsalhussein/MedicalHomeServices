//
// RequestDetailsView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct RequestDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.dismiss) private var dismiss
    @State var showNomintedProviders = false
    @StateObject var viewModel : RequestDetailsViewModel
    var isProvider : Bool
    init(requestId:Int,isProvider: Bool = false) {
        self._viewModel = StateObject(wrappedValue: RequestDetailsViewModel(requestId: requestId))
        self.isProvider = isProvider
    }
  
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Request Details")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                    
                    Spacer()
                    HStack (spacing:16){
 
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
                if isProvider {
                    acceptedRequestView
                } else {
                    if viewModel.isFetchingRequestStatus {
                        loadingView
                    } else {
                        if let provider = viewModel.requestStatusResponse?.tempProviderID {
                            let status = viewModel.requestStatusResponse?.status
                            switch status {
                            case "Accepted":
                                acceptedRequestView
                            default:
                                loadingView
                            }
                        } else {
                            rejectedRequestView
                        }
                    }
                }
                
            }
            .onAppear(perform: {
                viewModel.startFetchingRequestStatus()
            })
            .onDisappear(perform: {
                viewModel.stopFetchingProviders()
            })
            .onReceive(viewModel.dismissWhenDoneSubject, perform: { _ in
                dismiss()
            })
            .onReceive(viewModel.dismissAndNavigateToProvidersList, perform: { _ in
                showNomintedProviders.toggle()
            })
            .navigationDestination(isPresented: $showNomintedProviders, destination: {
                RequestNominatedProvidersView(requestId: viewModel.requestId)
                    .navigationBarBackButtonHidden()
            })
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    var loadingView : some View {
        return VStack(alignment: .center,spacing: 16) {
            Spacer()
            LottieView()
                .frame(width: 120,height: 120)
            Text("Your request is sent to the selected provider, please wait.")
                .font(.title3)
                .fontWeight(.semibold)
                .cornerRadius(8)
                .padding(.vertical, 4)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    var acceptedRequestView: some View {
        return VStack {
            Spacer()
            Text(isProvider ? "Your Request has Started" : "Your Request is Accepted")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.green)
                .padding(16)
                .background(.green.opacity(0.1))
                .cornerRadius(8)
                .multilineTextAlignment(.center)
            
            VStack {
                HStack(alignment:.center){
                    Image(isProvider ? "provider" : "customer")
                        .resizable()
                        .frame(width: 72, height: 72)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        .foregroundStyle(.gray)
                    
                    VStack(alignment:.leading,spacing:8) {
                        Text(isProvider ? (viewModel.requestStatusResponse?.tempProviderName ?? "") : ("Customer"))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .cornerRadius(8)
                            .padding(.vertical, 4)
                    }
                }
                .padding(.top,16)

                Spacer()
                    .frame(height: 200)
                HStack {
                    CustomButton(title: "Close Request",
                                 foregroundColor: .white,
                                 backgroundColor: .red) {
                        //Action for close
                        Task {
                            let userId = AppSettings.shared.currentUser?.userID
                            let requestStatus = UpdateRequestStatus(requestID: viewModel.requestId, userID: userId, status: 3)
                            await Helper.updateRequestStatus(requestStatus:requestStatus) { response in
                                dismiss()
                            }
                        }
                        
                    }
                        .frame(height: 50)
                        .padding(.horizontal,48)
                        .padding(.vertical,24)
                }
               
            }
            .background(.gray.opacity(0.1))
            .cornerRadius(18, corners: .allCorners)
            Spacer()
        }
    }
    
    var rejectedRequestView: some View {
        return VStack {
            Spacer()
            Text("Provider has rejected your request")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.red)
                .padding(16)
                .background(.red.opacity(0.1))
                .cornerRadius(8)
                .multilineTextAlignment(.center)
            Spacer()
          
        }
    }
}


#Preview {
    RequestDetailsView(requestId: 16)
}
