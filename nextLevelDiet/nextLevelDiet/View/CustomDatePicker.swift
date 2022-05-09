//
//  CustomDatePicker.swift
//  nextLevelDiet
//
//  Created by Ekrem Alp CIFTCI on 5/9/22.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate : Date
    
    //Month update on arrow button clicks...
    @State var currentMonth:Int = 0
    
    
    var body: some View {
        
        VStack (spacing:35){
            
            //Days...
            let days: [String] =
            ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            
            HStack (spacing:20){
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button{
                    withAnimation(){
                        currentMonth-=1
                }
                label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button{
                    withAnimation(){
                        currentMonth-=1
                    }
                }
                label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            //Day view...
            HStack (spacing:0){
                
                ForEach(days,id: \.self){ day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                    
                }
            }
            //Dates...
            //Lazy grid...
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns,spacing: 15){
                ForEach(extractDate()){
                    value in
                    Text("\(value.day)")
                        .font(.title3.bold())
                }
            }
        }
            .onChange(of: currentMonth){
                newValue in
                
            //Updating month...
            currentDate = getCurrentMonth()
        }
    }
        //extrating year and mounth for display...
        func extraDate()->[String]{
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM YYYY"
            let date = formatter.string(from: currentDate)
            return date.components(separatedBy: " ")
        }
        
    func getCurrentMonth()->Date{
            let calendar = Calendar.current
            guard let currentMonth = calendar.date(byAdding: .month,value: self.currentMonth, to: Date())
            else{
                return[]
        }
    }
        
        
        
        
    func extractDate()->[DateValue]{
        
        //Getting current month date
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        return currentMonth.getAllDates().compactMap{date -> DateValue
            in
            //Getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
        }
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Extending date to get current month dates...
extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        
        //Getting start date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        var range = calendar.range(of: .day, in: .month, for: startDate)!
        range.removeLast()
        
        //getting date...
        return range.compactMap{day -> Date in
            
            return calendar.date(byAdding: .day, value: day == 1 ? 0 : day, to: startDate)!
        }
    }
}
