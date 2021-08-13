//
//  SCBRequestManager.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import Moya

class SCBRequestManager {
    
    enum SCBError: Error {
        case apiError
        case parseFail
        case other
        
        var message: String {
            switch self {
            case .apiError:
                return "Unable to process your request. Try again later."
            case .parseFail:
                return "Error processing the request. Please try again later."
            case .other:
                return "Please try again later."
            }
        }
    }
    
    private let provider = MoyaProvider<SCBTarget>()
    
    public func getMobileList(completion: @escaping (Result<[Mobile],Error>) -> Void) {
        provider.request(.getMobiles) { result in
            switch result {
            case .success(let response):
                guard (200...299).contains(response.statusCode) else {
                    completion(.failure(SCBError.apiError))
                    return
                }
                
                do {
                    let mobiles = try response.map([Mobile].self)
                    completion(.success(mobiles))
                } catch {
                    completion(.failure(SCBError.parseFail))
                }
            case .failure:
                completion(.failure(SCBError.other))
            }
        }
    }
    
    public func getImages(
        mobileId: Int,
        completion: @escaping (Result<[MobileImage],Error>) -> Void
    ) {
        provider.request(.getImages(mobileId: mobileId)) { result in
            switch result {
            case .success(let response):
                guard (200...299).contains(response.statusCode) else {
                    completion(.failure(SCBError.apiError))
                    return
                }
                
                do {
                    let images = try response.map([MobileImage].self)
                    completion(.success(images))
                } catch {
                    completion(.failure(SCBError.parseFail))
                }
            case .failure:
                completion(.failure(SCBError.other))
            }
        }
    }
    
    // singleton
    public static var shared = SCBRequestManager()
    private init() {}
}

