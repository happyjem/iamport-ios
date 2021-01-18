//
// Created by BingBong on 2021/01/07.
//

import Foundation

struct Payment : Codable{
    let userCode: String
    let iamPortRequest: IamPortRequest

    init(userCode: String, iamPortRequest: IamPortRequest) {
        self.userCode = userCode
        self.iamPortRequest = iamPortRequest
    }
}