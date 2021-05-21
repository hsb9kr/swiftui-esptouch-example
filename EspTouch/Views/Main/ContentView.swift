//
//  ContentView.swift
//  EspTouch
//
//  Created by Sang bo Hong on 2021/05/22.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel = .init()
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("ssid: \(viewModel.ssid)")
                    Spacer()
                }
                HStack {
                    Text("bssid: \(viewModel.bssid)")
                    Spacer()
                }
            }
            
            Section {
                TextField("password", text: $viewModel.password)
                TextField("AES Key", text: $viewModel.aesKey)
                TextField("Data", text: $viewModel.data)
            }
            
            Button("done") {
                viewModel.createRequest()
            }
            .sheet(isPresented: $viewModel.showList, onDismiss: {
                if ESPProvisioner.share().isSyncing() {
                    ESPProvisioner.share().stopSync()
                } 
            }) {
                ProvisioningListView(viewModel: .init( viewModel.request!))
            }
            
            
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
