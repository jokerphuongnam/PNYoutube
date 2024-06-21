//
//  DI.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import Alamofire

func diRegister() -> Container {
    let container = Container()
    container.register(JSONDecoder.self) { _ in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }.inObjectScope(.container)
    
    container.register(URLSessionConfiguration.self) { _ in
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TimeInterval(60)
        configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.waitsForConnectivity = true
        configuration.allowsCellularAccess = false
        configuration.allowsConstrainedNetworkAccess = false
        configuration.allowsExpensiveNetworkAccess = false
        return configuration
    }.inObjectScope(.container)
    
    container.autoregister(RequestInterceptor.self, name: String(describing: YoutubeInterceptor.self), initializer: YoutubeInterceptor.init).inObjectScope(.container)
    
    container.register(Session.self) { resolver in
        Session(
            configuration: resolver.resolve(URLSessionConfiguration.self)!
        )
    }.inObjectScope(.container)
    
    container.autoregister(YoutubeNetworkProtocol.self, initializer: YoutubeNetwork.init).inObjectScope(.container)
    
    container.autoregister(YoutubeRepositoryProtocol.self, initializer: YoutubeRepository.init).inObjectScope(.container)
    
    container.autoregister(HomeUseCaseProtocol.self, initializer: HomeUseCase.init).inObjectScope(.container)
    
    return container
}
