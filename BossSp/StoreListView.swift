//
//  StoreListView.swift
//  BossSp
//
//  Created by 홍길동 on 2022/08/07.
//

import SwiftUI
import FirebaseFirestore
import MapKit


struct  storein : Identifiable,Codable{
    var id = UUID()
    var nameSto : String?
    var addSto :String?
    var typeSto : String?
    var longSto : Double
    var latSto : Double
    
}
var arrSto: [storein] = []
struct StoreListView: View {
      
        @State var listSto: [storein] = []
        
        //    init(){
        //        getinfo()
        //        listSto.append(contentsOf: arrSto)
        //        print("\(listSto)")
        //    }
        
        
        var body: some View {
            
            NavigationView{
                VStack{
                    Button("asd"){
                        getinfo()
                        print("\(arrSto)")
                    }
                
                    List{
                        //                NavigationLink(
                        //                    destination: StoreInfoView, label:{
                        //                ForEach(arrSto,id : \.id ){ info in
                        ForEach(listSto){  item in
                            HStack{
                                Image(systemName: "pawprint.fill")
                                    .resizable()
                                    .scaledToFit()//비율 유지
                                    .frame( height: 70)
                                    .cornerRadius(4)
                                VStack(alignment: .leading,spacing: 8){
                                    Text("\(item.nameSto!)")
                                        .fontWeight(.bold)
                                    Text("음식점 주소")
                                        .fontWeight(.semibold)
                                    Text("\(item.id)")
                                    //                                Text("\(list[listSto.index(before: 1)].typeSto!)")
                                    //                                    .fontWeight(.semibold)
                                    Text("\(item.typeSto!)")
                                        .fontWeight(.semibold)
                                }
                            }
                            //                    })
                            
                        }
                    }

                        
                    }
                .onAppear {
                    getinfo()
                    listSto.append(contentsOf: arrSto)
                }
                    .navigationTitle("음식점")
            }
        }

    }



func getinfo() {
        
        
        var  info =  storein( nameSto: "", addSto: "", typeSto: "", longSto: 0, latSto: 0) //구조체 초기화
        let db = Firestore.firestore()
        db.collection("stores").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let type = document.get("storeType") as? String
                    let address = document.get("storeAddress") as? String
                    let lat =  document.get("storeLatitude") as? String
                    let long = document.get("storeLongitude") as? String
                    let title1 = document.get("storeName")as? String
                    
                    
                    info.typeSto = type
                    info.addSto = address
                    info.latSto = Double(lat!)!
                    info.longSto = Double(long!)!
                    info.nameSto = title1
                   arrSto.append(info)//구조체 배열 삽입
                    
                    
                    // print("타입 : \(type)\n,주소 :\(address)\n,lat : \(Double(lat!)!)\n, long : \(long)\n,title :\(title1)")
                    
                    
                }
                print("func:\(arrSto)")
                print("f count: \(arrSto.count)")
                //  print("\(arrSto)\n")
                
            }
            
        }
        
    }


    struct ListView_Previews: PreviewProvider {
        static var previews: some View {
            StoreListView()
        }
    }
