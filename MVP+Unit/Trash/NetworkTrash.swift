//
//  NetworkTrash.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 21.05.2023.
//

import Foundation


//    func postRequestUrlForAuth(
//        email: String,
//        firstName: String,
//        lastName: String,
//        password: String,
//        completion: @escaping (Result<UserResponse, BackendError>) -> Void
//    )
//
//    func resetPassword(
//        email: String,
//        completion: @escaping (Result<UserResponse, BackendError>) -> Void
//    )

//    private func checkEmail(email: String, completion: @escaping (Result<Int, BackendError>) -> Void) {
//
//        let body = UserRequest(email: email)
//
//        var request = URLRequest(url: EndPoint.getRequestCheckEmail())
//        request.httpMethod = RequestType.post.value
//        request.httpBody = try? JSONEncoder().encode(body)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { _, response, error in
//            if let error = error {
//                completion(.failure(.decodeError(description: error.localizedDescription)))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("response error")
//                    completion(.failure(.decodeError(description: "response error")))
//                return
//            }
//
//            print(response.statusCode)
//
//            switch response.statusCode {
//            case 200:
//                    completion(.success(response.statusCode))
//            default:
//                    completion(.failure(.serverError(description: "invalid response.statusCode - ", statusCode: response.statusCode)))
//            }
//        }.resume()
//    }
//
//    func postRequestUrlForAuth(
//        email: String,
//        firstName: String,
//        lastName: String,
//        password: String,
//        completion: @escaping (Result<UserResponse, BackendError>) -> Void
//    ) {
//
//        checkEmail(email: email) { [ weak self ] result in
//            guard let self = self else { return }
//            do {
//                switch result {
//                case .success(let statusCode):
//
//                    print(statusCode)
//
//                    let body = UserRequest(
//                        email: email,
//                        firstName: firstName,
//                        lastName: lastName,
//                        password: password
//                    )
//
//                    var request = URLRequest(url: EndPoint.postRequestAuth())
//                    request.httpMethod = RequestType.post.value
//                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//                    request.httpBody = try? JSONEncoder().encode(body)
//
//                    URLSession.shared.dataTask(with: request) { data, response, error in
//
//                        if let error = error {
//                            print("error")
//                            completion(.failure(.decodeError(description: error.localizedDescription)))
//                        }
//
//                        guard let response = response as? HTTPURLResponse else {
//                            print("response error")
//                            completion(.failure(.decodeError(description: "response error")))
//                            return
//                        }
//                        print(response.statusCode)
//
//                        DispatchQueue.main.async {
//
//                            switch StatusCode.returnResult(for: response.statusCode) {
//
//                            case .information:
//                                print("Status code :- \(response.statusCode)")
//                                completion(.failure(.information(description: "clientError", statusCode: response.statusCode)))
//
//                            case .success:
//                                guard let data = data else {
//                                    completion(.failure(.unresolved(description: "catch failure", statusCode: response.statusCode)))
//                                    return
//                                }
//                                print("Status code :- \(response.statusCode)")
//                                do {
//                                    let model = try JSONDecoder().decode(UserResponse.self, from: data)
//                                    completion(.success(model))
//                                }
//                                catch {
//                                    completion(.failure(.decodeError(description: "Error with data")))
//                                }
//                            case .resursive:
//                                print("Status code :- \(response.statusCode)")
//                                completion(.failure(.redirection(description: "resursive", statusCode: response.statusCode)))
//
//                            case .authError:
//                                print("Status code :- \(response.statusCode)")
//                                completion(.failure(.authError(description: "authError", statusCode: response.statusCode)))
//
//                            case .clientError:
//                                print("Status code :- \(response.statusCode)")
//                                completion(.failure(.clientError(description: "clientError", statusCode: response.statusCode)))
//
//                            case .serverError:
//                                print("Status code :- \(response.statusCode)")
//                                completion(.failure(.serverError(description: "serverError", statusCode: response.statusCode)))
//                            }
//                        }
//                    }.resume()
////                case .failure(let error):
////                    print(error)
////                }
////            }
////            catch {
////                print("Catch")
////            }
////        }
//    }
//
//    func resetPassword(email: String, completion: @escaping (Result<UserResponse, BackendError>) -> Void) {
//
//        let body = UserRequest(email: email)
//
//        var request = URLRequest(url: EndPoint.getRequestResetPassword())
//        request.httpBody = try? JSONEncoder().encode(body)
//        request.httpMethod = RequestType.post.value
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            guard let data = data, error == nil else {
//                completion(.failure(.decodeError(description: error?.localizedDescription)))
//                return
//            }
//
//            guard let response = try? JSONDecoder().decode(UserResponse.self, from: data) else {
//                completion(.failure(.decodeError(description: "response error")))
//                return
//            }
//
//            completion(.success(response))
//
//        }.resume()
//    }
//}
