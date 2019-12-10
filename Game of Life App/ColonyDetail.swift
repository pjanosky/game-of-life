//
//  ColonyDetail.swift
//  Conway's Game of Life
//
//  Created by Peter Janosky on 11/16/19.
//

import SwiftUI

struct ColonyDetail: View {
    @EnvironmentObject var data: Data
    @Binding var colony: Colony
    @State private var showTemplatesModal = false
    @State var isShowingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack() {
                    Button(action: {
                        
                        self.isShowingAlert.toggle()
                    }) {
                        Text("Save As Template")
                    }.frame(width: 200, alignment: .leading)


                    TextField("Name", text: self.$colony.name)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    
                    Spacer()
                    
                    Button(action: {
                        self.showTemplatesModal = true
                    }) {
                        Text("Templates")
                    }.sheet(isPresented: self.$showTemplatesModal) {
                        TemplatesModal(colony: self.$colony, showing: self.$showTemplatesModal)
                            .environmentObject(self.data)
                    }.frame(width: 200, alignment: .trailing)
                }.padding(.horizontal)
                
                Text("Generation \(self.colony.generationNumber),  \(self.colony.numberLivingCells) \(self.colony.numberLivingCells == 1 ? "Cell" : "Cells") Alive")
                    .font(.headline)
                
                GridView(colony: self.$colony).padding(15)
                ControlsView(colony: self.$colony, width: geometry.size.width)
                    .padding(.horizontal)
                }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .textFieldAlert(isShowing: self.$isShowingAlert, text: self.$data.colonies[self.data.currentColony].name, colony: self.colony)
    }
}


struct ColonyDetail_Previews: PreviewProvider {
    @State static var colony = Data().colonies[0]
    static var previews: some View {
        ColonyDetail(colony: $colony)
    }
}
