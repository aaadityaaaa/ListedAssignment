//
//  LineChartDemo.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 05/07/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    let data: [String: Int]
    var body: some View {
        Chart {
            ForEach(data.sorted(by: <), id: \.key) { key, value in
                LineMark(
                    x: .value("Month", key),
                    y: .value("Value", value)
                )
            }
        }
        .chartXAxisLabel(position: .top, alignment: .leading) {
            Text("Overview")
                .foregroundColor(Color(uiColor: .lightSecondaryColor()))
                .font(.custom("Figtree-SemiBold", size: 16))
                .padding(.leading, 5)
        }
        
        .frame(height: 200)
    }
}


