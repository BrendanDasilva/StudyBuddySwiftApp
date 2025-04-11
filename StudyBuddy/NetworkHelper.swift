//
//  NetworkHelper.swift
//  StudyBuddy
//
//  Created by jessica lee on 2025-04-10.
//

import Foundation

class NetworkHelper {
    // Define base URL for the backend API
    static let baseURL = "http://your-backend-url-here.com/api/flashcards"
    
    // Function to fetch the local device's Wi-Fi IP address
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

    // Function to build the backend URL dynamically with the device's IP
    static func getBackendURL(endpoint: String) -> URL? {
        if let ip = getWiFiAddress() {
            return URL(string: "http://\(ip):3000\(endpoint)")
        }
        return nil
    }
    
    // Fetch flashcards by groupId
    static func fetchFlashCards(for groupId: String, completion: @escaping ([FlashCard]?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(groupId)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let flashCards = try decoder.decode([FlashCard].self, from: data)
                completion(flashCards, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // Add a new flashcard
    static func addFlashCard(question: String, answer: String, groupId: String, visibility: String, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        let flashCardData: [String: Any] = [
            "question": question,
            "answer": answer,
            "groupId": groupId,
            "visibility": visibility
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: flashCardData) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }

    // Update a flashcard
    static func updateFlashCard(id: UUID, question: String, answer: String, visibility: String, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)") else { return }
        
        let flashCardData: [String: Any] = [
            "question": question,
            "answer": answer,
            "visibility": visibility
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: flashCardData) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }

    // Delete a flashcard
    static func deleteFlashCard(id: UUID, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
}
