//
//  NetworkManager.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 02/07/23.
//

import UIKit

protocol ObjectService {
    func getData(completed: @escaping (Result<Response, ErrorMessage>) -> Void)
}

class NetworkManager: ObjectService {
        
    func getData(completed: @escaping (Result<Response, ErrorMessage>) -> Void) {
        
        let apiURL = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew")!

        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"

        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"

        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(Response.self, from: data)
                completed(.success(object))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
