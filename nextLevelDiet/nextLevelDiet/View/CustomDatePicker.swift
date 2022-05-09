//
//  CustomDatePicker.swift
//  nextLevelDiet
//
//  Created by Ekrem Alp CIFTCI on 5/9/22.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate : Date
    
    var body: some View {
        
        VStack{
            HStack (spacing:20){
                VStack(alignment: .leading, spacing: 10){
                    Text("2022")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("September")
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button{
                    
                }
                label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button{
                    
                }
                label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding()
        }
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
