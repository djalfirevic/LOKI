//
//  WebServiceManager.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import UIKit
import Network

enum HttpMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

class RESTManager {
	
	// MARK: - Properties
	static let shared = RESTManager()
	private let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
	private let basePath = "http://api.openweathermap.org/data/2.5/weather?"
	private let appId = "b5a042da0f3eaf66ef4a980abb14e17d"
	private var isConnected = true
	
	// MARK: - Initializer
	private init() {}
	
	// MARK: - Public API
	func hasInternetConnection() -> Bool {
		return self.isConnected
	}
	
	func configureNetworkMonitor() {
		monitor.pathUpdateHandler = { path in
			if path.status == .satisfied {
				self.isConnected = true
			} else {
				self.isConnected = false
			}
		}
		
		let queue = DispatchQueue(label: "NetworkMonitor")
		monitor.start(queue: queue)
	}
	
	func GET<T: Codable>(from urlString: String, completion: @escaping (_ object: T?, _ error: Error?) -> ()) {
		if hasInternetConnection() {
			let fullPath = "\(basePath)\(urlString)&appId=\(appId)"
			Logger.log(message: fullPath, type: .info)
			
			guard let encoded = fullPath.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) else {
				fatalError("🛑 URL not formed")
			}
			
			let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
			let request = configureRequest(for: url, method: .get)
			
			let task = session.dataTask(with: request) { (data, response, error) in
				if let error = error {
					DispatchQueue.main.async {
						completion(nil, error)
						Logger.log(message: "Error = \(String(describing: error))", type: .debug)
					}
				}
				
				// Data acquired
				do {
					if let data = data {
						let decoder = JSONDecoder()

						let object = try decoder.decode(T.self, from: data)
						
						DispatchQueue.main.async {
							completion(object, nil)
						}
					} else {
						DispatchQueue.main.async {
							completion(nil, error)
						}
					}
				} catch {
					DispatchQueue.main.async {
						completion(nil, error)
					}
					
					Logger.log(message: "Decoding error: \(error)", type: .error)
				}
			}
			
			task.resume()
		}
	}
	
	// MARK: - Private API
	private func configureRequest(for url: URL, method: HttpMethod) -> URLRequest {
		var request = URLRequest(url: url)
		
		request.httpMethod = method.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		
		return request
	}
	
}

