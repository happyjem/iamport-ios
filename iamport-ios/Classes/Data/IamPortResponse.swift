//
// Created by BingBong on 2021/01/07.
//

import Foundation
import Then

public class IamPortResponse: Then {
    public var imp_success: Bool? = false
    public var success: Bool? = false
    public var imp_uid: String?
    public var merchant_uid: String?
    public var error_msg: String? = nil
    public var error_code: String? = nil

    static func structToClass(_ impStruct: IamPortResponseStruct) -> IamPortResponse {
        IamPortResponse().then { it in
            it.imp_success = impStruct.imp_success
            it.success = impStruct.success
            it.imp_uid = impStruct.imp_uid
            it.merchant_uid = impStruct.merchant_uid
            it.error_msg = impStruct.error_msg
            it.error_code = impStruct.error_code
        }
    }

    static func makeSuccess(payment: Payment, prepareData: PrepareData? = nil, msg: String) -> IamPortResponse {
        IamPortResponse().then { it in
            it.imp_success = true
            it.success = true
            it.imp_uid = prepareData?.impUid
            it.merchant_uid = payment.iamPortRequest.merchant_uid
            it.error_msg = msg
        }
    }

    static func makeFail(payment: Payment, prepareData: PrepareData? = nil, msg: String) -> IamPortResponse {
        IamPortResponse().then { it in
            it.imp_success = false
            it.success = false
            it.imp_uid = prepareData?.impUid
            it.merchant_uid = payment.iamPortRequest.merchant_uid
            it.error_msg = msg
        }
    }
}


public struct IamPortResponseStruct {
    var imp_success: Bool? = false
    var success: Bool? = false
    var imp_uid: String?
    var merchant_uid: String?
    var error_msg: String? = nil
    var error_code: String? = nil

    enum CodingKeys: String, CodingKey {
        case imp_success, success, imp_uid, merchant_uid, error_msg, error_code
    }
}

extension IamPortResponseStruct: Decodable {
    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)


        let decodeImp_success = try? values.decode(String.self, forKey: .imp_success)
        if let imp = decodeImp_success {
            guard let imp_successBool = Bool(imp) else {
                fatalError("The imp_success is not an Bool")
            }
            imp_success = imp_successBool
        }

        let decodeSuccess = try? values.decode(String.self, forKey: .success)
        if let success = decodeSuccess {
            guard let successBool = Bool(success) else {
                fatalError("The success is not an Bool")
            }
            self.success = successBool
        }

        imp_uid = try? values.decode(String.self, forKey: .imp_uid)
        merchant_uid = try? values.decode(String.self, forKey: .merchant_uid)
        error_code = try? values.decode(String.self, forKey: .error_code)
        error_msg = try? values.decode(String.self, forKey: .error_msg)
    }
}

