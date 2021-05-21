//
//  ViewModel.swift
//  EspTouch
//
//  Created by Sang bo Hong on 2021/05/22.
//

import SwiftUI
import CoreLocation

class ViewModel:NSObject, ObservableObject {

    let locationManager: CLLocationManager = CLLocationManager()
    @Published var bssid: String = ""
    @Published var ssid: String = ""
    @Published var password: String = ""
    @Published var aesKey: String = ""
    @Published var data: String = ""
    @Published var showList: Bool = false
    @Published var request: ESPProvisioningRequest?
    
    func fetchData() {
        
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                loadWifiInformation()
                return
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return
            case .denied, .restricted:
                return
            default:
                return
        }
    }
    
    func loadWifiInformation() {
        bssid = ESPTools.getCurrentBSSID() ?? ""
        ssid = ESPTools.getCurrentWiFiSsid() ?? ""
    }
    
    func createRequest() {
        let request: ESPProvisioningRequest = .init()
        request.bssid = ESP_ByteUtil.getBytesBy(bssid)
        request.ssid = ESP_ByteUtil.getBytesBy(ssid)
        request.password = ESP_ByteUtil.getBytesBy(ssid)
        
        if ESPProvisioner.share().isSyncing() {
            ESPProvisioner.share().stopSync()
        } else {
            self.request = request
            showList = true
        }
    }
}

extension ViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            loadWifiInformation()
            return
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            return
        default:
            return
        }
    }
}
