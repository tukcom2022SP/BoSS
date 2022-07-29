//
//  Place.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/29.
//

import SwiftUI
import MapKit

struct Place: Identifiable{
    var id = UUID().uuidString
    var place: CLPlacemark
}
