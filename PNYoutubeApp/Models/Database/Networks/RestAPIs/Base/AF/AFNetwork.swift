//
//  AFNetwork.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Alamofire
import Foundation

protocol AFNetwork: Actor, AnyObject {
    
}

extension AFNetwork {
    func send<T: AFRequest>(session: Session, decoder: JSONDecoder, request: T) async throws -> T.Response {
        let restRequest = session.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: request.httpHeaderFields,
            interceptor: request.interceptor
        )
        
        return try await withTaskCancellationHandler {
            return try await withCheckedThrowingContinuation { [weak self, weak restRequest] continuation in
                guard let self, let restRequest else {
                    continuation.resume(throwing: AppError.ownerNil)
                    return
                }
                
#if DEBUG
                let backgroundQueue = DispatchQueue.init(
                    label: "\(self.self)",
                    qos: .background
                )
                
                restRequest.cURLDescription(
                    on: backgroundQueue
                ) { [weak self] description in
                    guard self != nil else {
                        continuation.resume(throwing: AppError.ownerNil)
                        return
                    }
                    print("Request \(description)")
                }
#endif
                restRequest.responseDecodable(
                    of: T.Response.self,
                    queue: DispatchQueue.init(
                        label: "\(self.self)",
                        qos: .utility
                    )
                ) { response in
                    guard let data = response.data else {
                        continuation.resume(throwing: AFNetworkError.dataNotExist)
                        return
                    }
                    guard let statusCode = response.response?.statusCode else {
                        continuation.resume(throwing: AFNetworkError.statusCodeNotExist)
                        return
                    }
#if DEBUG
                    print("Status code:", statusCode)
#endif
                    
                    switch statusCode {
                    case 200..<500:
#if DEBUG
                        backgroundQueue.async {
                            print("==============================================")
                            if let returnData = String(data: data, encoding: .utf8) {
                                print(String(returnData))
                            } else {
                                print("Can't parse to String data")
                            }
                        }
#endif
                        do {
                            var response = try decoder.decode(T.Response.self, from: data)
                            response.request = restRequest
                            continuation.resume(returning: response)
                        } catch {
#if DEBUG
                            backgroundQueue.async {
                                print("error: ", error)
                            }
#endif
                            continuation.resume(
                                throwing: AFNetworkError.unknownError(
                                    AFResponseError(
                                        error.localizedDescription,
                                        statusCode: statusCode
                                    )
                                )
                            )
                        }
                    default:
                        if let error = String(data: data, encoding: .utf8) {
                            continuation.resume(
                                throwing: AFNetworkError.otherError(
                                    AFResponseError(
                                        error,
                                        statusCode: statusCode
                                    )
                                )
                            )
                        } else {
                            continuation.resume(
                                throwing: AFNetworkError.otherError(
                                    AFResponseError(
                                        false,
                                        statusCode: statusCode
                                    )
                                )
                            )
                        }
                    }
                }
            }
        } onCancel: { [weak restRequest] in
            guard let restRequest else { return }
            Task { [weak restRequest] in
                guard let restRequest else { return }
                restRequest.cancel()
            }
        }
    }
}
