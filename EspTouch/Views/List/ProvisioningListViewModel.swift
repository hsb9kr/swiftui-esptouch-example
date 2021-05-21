//
//  ProvisioningListViewModel.swift
//  EspTouch
//
//  Created by Sang bo Hong on 2021/05/22.
//

import SwiftUI

class ProvisioningListViewModel:NSObject, ObservableObject {
    
    let request: ESPProvisioningRequest
    @Published var results: [ESPProvisioningResult] = []
    
    init(_ request: ESPProvisioningRequest) {
        self.request = request
    }
    
    func fetchData() {
        startProvisioning()
    }
    
    func startProvisioning() {
        guard !ESPProvisioner.share().isProvisioning() else { return }
        ESPProvisioner.share().startProvisioning(self.request, with: self)
    }
    
    func stopProvisioning() {
        guard ESPProvisioner.share().isProvisioning() else { return }
        ESPProvisioner.share().stopProvisioning()
    }
}

extension ProvisioningListViewModel: ESPProvisionerDelegate {
    func onSyncStart() {
        debugPrint(#function)
    }
    
    func onSyncStop() {
        debugPrint(#function)
    }
    
    func onSyncError(_ exception: NSException) {
        debugPrint(#function)
        debugPrint(exception)
    }
    
    func onProvisioningStart() {
        debugPrint(#function)
    }
    
    func onProvisioningStop() {
        debugPrint(#function)
    }
    
    func onProvisioningError(_ exception: NSException) {
        debugPrint(#function)
        debugPrint(exception)
    }
    
    func onProvisoningScanResult(_ result: ESPProvisioningResult) {
        debugPrint(#function)
        debugPrint(result)
        results.append(result)
    }
}
