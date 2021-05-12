//
//  UniqueUUIDManager.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/12.
//  Copyright © 2021 depromeet. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyJSON
import Alamofire

class UniqueUUIDManager {
    
    // MARK: property
    
    var uniqueUUID: String = ""
    
    // MARK: internal function
    static let shared: UniqueUUIDManager = {
        let instance = UniqueUUIDManager()
        if let uuid = instance.getUniqueUUID() {
            instance.uniqueUUID = uuid
        }
        return instance
    }()
    
    func registAndSaveUUID(completeHandler: @escaping () -> Void, failureHandler: @escaping (String) -> Void) {
        let uuid: String = createUUID()
        registUniqueUUIDQuery(willRegistedUUID: uuid, completeHandler: { [weak self] in
            self?.saveUUID(registedUUID: uuid)
            completeHandler()
        }, failureHandler: { errStr in
            failureHandler(errStr)
        })
    }
    
    func getUniqueUUID() -> String? {
        let bundleID: String = Bundle.main.bundleIdentifier ?? "com.depromeet.myRecipick"
        let keychain = Keychain(service: bundleID)
        return keychain[KeyChainKeyDefine.UNIQUE_UUID_KEY]
    }
    
    // MARK: private function
    private func createUUID() -> String {
        return UUID().uuidString
    }
    
    private func saveUUID(registedUUID: String) { // 반드시 서버에 등록되어있는 uuid를 등록해야한다.
        let bundleID: String = Bundle.main.bundleIdentifier ?? "com.depromeet.myRecipick"
        let keychain = Keychain(service: bundleID)
        keychain[KeyChainKeyDefine.UNIQUE_UUID_KEY] = registedUUID
    }
    
    private func registUniqueUUIDQuery(willRegistedUUID: String, completeHandler: @escaping () -> Void, failureHandler: @escaping (String) -> Void) {
        let httpRequest: HttpRequest = HttpRequest(url: APIDefine.REGIST_USER, method: .post, parameters: ["id": willRegistedUUID], headers: .default, encoding: .jsonDefault)
        ServerUtil.shared.request(with: httpRequest) { (responseJson) in
            if 200..<300 ~= responseJson["status"].intValue {
                completeHandler()
            } else {
                failureHandler("[\(responseJson["code"])]\n\(responseJson["message"])")
            }
        } failure: { (err) in
            failureHandler(err.localizedDescription)
        }
    }

}
