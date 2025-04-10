//
//  NetworkHelper.swift
//  StudyBuddy
//
//  Created by jessica lee on 2025-04-10.
//

import Foundation

class NetworkHelper {
    static func getWiFiAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?

        if getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr {
            for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
                let interface = ptr.pointee
                let addrFamily = interface.ifa_addr.pointee.sa_family

                if addrFamily == UInt8(AF_INET), let name = String(validatingUTF8: interface.ifa_name), name == "en0" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr,
                                socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname,
                                socklen_t(hostname.count),
                                nil,
                                socklen_t(0),
                                NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
            freeifaddrs(ifaddr)
        }

        return address
    }

    static func getBackendURL(endpoint: String) -> URL? {
        if let ip = getWiFiAddress() {
            return URL(string: "http://\(ip):3000\(endpoint)")
        }
        return nil
    }
}
