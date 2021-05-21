//
//  ProvisioningListView.swift
//  EspTouch
//
//  Created by Sang bo Hong on 2021/05/22.
//

import SwiftUI

struct ProvisioningListView: View {
    
    @ObservedObject var viewModel: ProvisioningListViewModel
    
    var body: some View {
        List {
            ForEach(0..<viewModel.results.count) { index in
                VStack {
                    HStack {
                        Text(viewModel.results[index].address)
                        Spacer()
                    }
                    
                    HStack {
                        Text(viewModel.results[index].bssid)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .onDisappear {
            viewModel.stopProvisioning()
        }
    }
}

struct ProvisioningListView_Previews: PreviewProvider {
    static var previews: some View {
        ProvisioningListView(viewModel: .init(.init()))
    }
}
