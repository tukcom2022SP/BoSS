//
//  StoreListView.swift
//  BossSp
//
//  Created by 홍길동 on 2022/08/07.
//

import SwiftUI
import FirebaseFirestore
import MapKit

struct StoreListView: View {
    @ObservedObject var storeModel = StoreModel.shared
    @ObservedObject var mapData = MapDataModel.shared.mapData
    @Binding var tabSelection: Int
    var body: some View {
        
        NavigationView{
            VStack{
                List{
                    ForEach(storeModel.stores, id: \.strName) { store in
                        HStack{
                            Image(systemName: "pawprint.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(4)
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(store.strName)")
                                    .fontWeight(.bold)
                                Text("\(store.strAddress)")
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .allowsTightening(true)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Button {
                                    tabSelection = 1
                                    mapData.setMapRegion(coordinate: CLLocationCoordinate2D(latitude: Double(store.strLatitude)!, longitude: Double(store.strLongitude)!))
                                } label: {
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .frame(width: 15, height: 15, alignment: .trailing)
                                }
                            }

                        }
                    }
                }
            }
            .navigationTitle("맛집 리스트")
        }
    }

}
//
//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreListView(tabSelection: )
//    }
//}
