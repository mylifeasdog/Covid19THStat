//
//  Prayuth.swift
//  Covid19THStat
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import Combine
import SwiftUI

struct Prayuth: View
{
    // MARK: - Presenter
    
    @ObservedObject private var anutin: Anutin
    
    // MARK: - Initializer
    
    init(
        anutin: Anutin)
    {
        self.anutin = anutin
    }
    
    // MARK: -
    
    var body: some View
    {
        ScrollView
        {
            HStack
            {
                Text(anutin.morTaweesilpSpeech.updatedString)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 44.0)
                
                Button(
                    action: { anutin.reloadData() },
                    label: {
                        HStack(spacing: .medium) {
                            if anutin.isRefreshing
                            {
                                ProgressView()
                                Text("Refreshing...")
                            }
                            else
                            {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            } } })
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 44.0)
            }
            VStack(spacing: 0.0)
            {
                HStack(spacing: 0.0)
                {
                    Text(anutin.morTaweesilpSpeech.casesString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 3,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .red)
                    Text(anutin.morTaweesilpSpeech.deathsString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 3,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .black)
                }
                
                HStack(spacing: 0.0)
                {
                    Text(anutin.morTaweesilpSpeech.recoveredString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 3,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .green)
                    Text(anutin.morTaweesilpSpeech.hospitalizedString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 3,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .orange)
                }
                HStack(spacing: 0.0)
                {
                    Text(anutin.morTaweesilpSpeech.percentTestsString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .yellow)
                    Text(anutin.morTaweesilpSpeech.percentCasesString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .red)
                }
                
                HStack(spacing: 0.0)
                {
                    Text(anutin.morTaweesilpSpeech.oneCasePerPeopleString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .orange)
                    Text(anutin.morTaweesilpSpeech.oneDeathPerPeopleString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            padding: EdgeInsets(
                                top: .medium,
                                leading: .zero,
                                bottom: .medium,
                                trailing: .zero),
                            backgroundColor: .black)
                }
            }
        }
        .onAppear()
        {
            anutin.reloadData()
        }
    }
}

struct StatView_Previews: PreviewProvider
{
    static var previews: some View
    {
        Prayuth(
            anutin: Anutin(
                morTaweesilpSpeech: nil))
    }
}
