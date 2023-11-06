//
//  NetworkManager.swift
//  DemoUI
//
//  Created by MR Tailor on 20/10/23.
//

import SwiftUI
import Foundation
import Swift
import Alamofire

@MainActor
class NetworkManager: ObservableObject {
    @Published var loginResponse : LoginModel!
    
    func postLoginService(username:String,password:String) async {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        let urlSession = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("en", forHTTPHeaderField: "language")
        request.setValue("Asia", forHTTPHeaderField: "timezone")
        request.setValue("Basic 0", forHTTPHeaderField: "Authorization")
        request.httpBody = "member=lokesh".data(using: .utf8)
        do {
            //let (data,response) = try await urlSession.data(from: url)
            let (data,response) = try await urlSession.data(for: request)
            print(response)
            self.loginResponse = try JSONDecoder().decode(LoginModel.self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
        }
        
//        do {
//            let data = try await Service().afRequest(url: url)
//            self.loginResponse = try JSONDecoder().decode(LoginModel.self, from: data)
//        } catch {
//            debugPrint(error.localizedDescription)
//        }
    }
}

class Service  {
    func afRequest(url:URL) async throws -> Data {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(url, method: .get).validate().responseData { response in
                if let data = response.data {
                    continuation.resume(returning: data)
                    return
                }
                if let err = response.error {
                    continuation.resume(throwing: err)
                    return
                }
                fatalError("should not get here")
            }
        }
    }
}
public extension DataRequest {
    @discardableResult
    func asyncDecodable<T: Decodable>(of type: T.Type = T.self,
                                      queue: DispatchQueue = .main,
                                      dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor,
                                      decoder: DataDecoder = JSONDecoder(),
                                      emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                                      emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods) async throws -> T {

        return try await withCheckedThrowingContinuation({ continuation in

            self.responseDecodable(of: type, queue: queue, dataPreprocessor: dataPreprocessor, decoder: decoder, emptyResponseCodes: emptyResponseCodes, emptyRequestMethods: emptyRequestMethods) { response in

                switch response.result {
                case .success(let decodedResponse):
                    continuation.resume(returning: decodedResponse)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}

struct LoginModel: Codable {
    let code : Int
    let message : String
    let error : Int
    let data : LoginData
}

struct LoginData: Codable {
    let userID : Int
    let name : String
    let avator : String
    let email : String
    let mobile : String
}
