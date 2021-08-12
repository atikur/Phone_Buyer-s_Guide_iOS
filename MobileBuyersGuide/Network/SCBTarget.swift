//
//  SCBTarget.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//


import Moya

enum SCBTarget {
    case getMobiles
    case getImages(mobileId: Int)
}

extension SCBTarget: TargetType {
    public var baseURL: URL {
        return URL(string: "https://scb-test-mobile.herokuapp.com/api")!
    }
    
    public var path: String {
        switch self {
        case .getMobiles:
            return "/mobiles"
        case .getImages(let mobileId):
            return "/mobiles/\(mobileId)/images"
        }
    }
    
    public var method: Method {
        switch self {
        case .getMobiles, .getImages:
            return .get
        }
    }
    
    public var sampleData: Data {
        Data()
    }
    
    public var task: Task {
        switch self {
        case .getMobiles, .getImages:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getMobiles, .getImages:
            return .none
        }
    }
}
