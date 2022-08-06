//
//  StoreInfoList.swift
//  BossSp
//
//  Created by 이정동 on 2022/08/06.
//

import Foundation

class StoreModel: ObservableObject {
    static let shared = StoreModel()
    
    @Published var stores : [
        (
            strName: String,
            strAddress: String,
            strDescript: String,
            strType: String
        )
    ] = []
    
    private init() { }
}
