//
//  MapDataModel.swift
//  BossSp
//
//  Created by 이정동 on 2022/08/08.
//

import Foundation

class MapDataModel : ObservableObject {
    static let shared = MapDataModel()
    
    @Published var mapData = MapViewModel()
    
    private init() {}
}
