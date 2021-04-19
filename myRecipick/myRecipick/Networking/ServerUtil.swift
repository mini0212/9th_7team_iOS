//
//  ServerUtil.swift
//  myRecipick
//
//  Created by Min on 2021/04/12.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON

protocol HttPRequestRx {
    func requestRx<T: Decodable>(with request: HttpRequest) -> Observable<T>
}

struct ServerUtil {
    static let shared = ServerUtil()
    private init() { }
    let manager = Alamofire.Session.default
    
    @discardableResult func request(with request: HttpRequest, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) -> DataRequest? {
        let baseURL = APIDefine.BASE_URL
        let dataRequest: DataRequest = AF.request(baseURL + request.url,
                                                  method: request.method.toAlamofire,
                                                  parameters: request.parameters,
                                                  encoding: request.encoding?.toAlamofire ?? JSONEncoding.default,
                                                  headers: request.headers?.toAlamofire
        ).validate().responseJSON { (responseObject) -> Void in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                success(resJson)
            case .failure(let error):
                let errorValue: Error = error
                failure(errorValue)
            }
        }
        return dataRequest
    }
}

extension ServerUtil: ReactiveCompatible { }

extension Reactive where Base == ServerUtil {
    func requestRx<T>(with request: HttpRequest) -> Observable<T> where T: Decodable {
        return base.manager.httpRequest(with: request)
            .decodedObject()
    }
}

extension Observable where Element == (HTTPURLResponse, Any) {
    fileprivate func decodedObject<T: Decodable>() -> Observable<T> {
        return flatMap { (response, json) -> Observable<T> in
            switch response.statusCode {
            case 200..<300:
                if let response: T = JSONConverter.decode(from: json) {
                    return .just(response)
                } else {
                    return .error(self.updateWithError(with: json))
                }
            default:
                return .error(self.updateWithError(with: json))
            }
        }
    }
    
    fileprivate func updateWithError(with json: Any) -> Error {
        if let error: APIError = JSONConverter.decode(from: json) {
            return error
        } else {
            return ErrorMessage(message: "unknown Error", name: 500)
        }
    }
}



extension Session {
    fileprivate func httpRequest(with httpRequest: HttpRequest) -> Observable<(HTTPURLResponse, Any)> {
        let baseURL = APIDefine.BASE_URL
        return Session.default.rx.responseJSON(httpRequest.alamofireMethod,
                                               baseURL + httpRequest.url,
                                               parameters: httpRequest.parameters,
                                               encoding: httpRequest.alamofireEncoding,
                                               headers: httpRequest.alamofireHeaders)
    }
}
