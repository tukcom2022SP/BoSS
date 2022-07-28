//
//  MenuBar.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/28.
//

import SwiftUI

struct MenuBar: View {
    @State private var click = [true, false, false]
    var body: some View {

        HStack(alignment: .bottom, spacing: .leastNormalMagnitude){
            Spacer()
            Button {
                click[0] = true
                click[1] = false
                click[2] = false
            } label: {
                if click[0]{
                    Image(systemName: "map.fill")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }else{
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                
            }
            Spacer()
            Button {
                click[0] = false
                click[1] = true
                click[2] = false
            } label: {
                if click[1]{
                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }else{
                    Image(systemName: "heart.circle")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                
            }
            Spacer()
            Button {
                click[0] = false
                click[1] = false
                click[2] = true
            } label: {
                if click[2]{
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }else{
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                
            }
            Spacer()
        }
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar()
    }
}
