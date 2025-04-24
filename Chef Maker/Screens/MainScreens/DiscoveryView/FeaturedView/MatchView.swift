//
//  MatchView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 18.04.25.
//

import SwiftUI

struct MatchView: View {
    @Binding var text: String
    @Namespace var namespace
    @State var show: Bool = false

       var body: some View {
           TextField("Search", text: $text){
               
           }

        
       }
}

#Preview{
    MatchView(text: .constant(""))
}
