//
//  SCBRequestManager.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import Moya

class SCBRequestManager {
    
    enum SCBError: Error {
        case other
        case noData
        case parseFail
    }
    
    private let provider = MoyaProvider<SCBTarget>()
    
    public func getMobileList(completion: @escaping (Result<[Mobile],Error>) -> Void) {
        provider.request(.getMobiles) { result in
            switch result {
            case .success(let response):
                guard let mobiles = try? response.map([Mobile].self) else { return }
                completion(.success(mobiles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // singleton
    public static var shared = SCBRequestManager()
    private init() {}
}

