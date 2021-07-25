//
//  StatWidget.swift
//  Widget
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import Combine
import WidgetKit
import SwiftUI
import Intents

struct CoconutMilk : View
{
    // MARK: - Properties
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    private var morTaweesilpSpeech: MorTaweesilpSpeech
    
    // MARK: - Initializer
    
    init(morTaweesilpSpeech: MorTaweesilpSpeech)
    {
        self.morTaweesilpSpeech = morTaweesilpSpeech
    }
    
    // MARK: -
    
    var body: some View
    {
        VStack(spacing: 0.0)
        {
            Text(morTaweesilpSpeech.updatedString)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(
                    EdgeInsets(
                        top: .small,
                        leading: family == .systemSmall ? .medium : .zero,
                        bottom: .small,
                        trailing: family == .systemSmall ? .medium: .zero))
            
            HStack(spacing: 0.0)
            {
                Text(morTaweesilpSpeech.casesString)
                    .defailtModifier(
                        alignment: .center,
                        font: .headline,
                        lineLimit: 3,
                        maxHeight: .infinity,
                        padding: EdgeInsets(
                            top: .extraSmall,
                            leading: .extraSmall,
                            bottom: .extraSmall,
                            trailing: .extraSmall),
                        backgroundColor: .red)
                Text(morTaweesilpSpeech.deathsString)
                    .defailtModifier(
                        alignment: .center,
                        font: .headline,
                        lineLimit: 3,
                        maxHeight: .infinity,
                        padding: EdgeInsets(
                            top: .extraSmall,
                            leading: .extraSmall,
                            bottom: .extraSmall,
                            trailing: .extraSmall),
                        backgroundColor: .black)
            }
            .frame(
                maxHeight: .infinity)
            HStack(spacing: 0.0)
            {
                Text(morTaweesilpSpeech.recoveredString)
                    .defailtModifier(
                        alignment: .center,
                        font: .headline,
                        lineLimit: 3,
                        maxHeight: .infinity,
                        padding: EdgeInsets(
                            top: .extraSmall,
                            leading: .extraSmall,
                            bottom: .extraSmall,
                            trailing: .extraSmall),
                        backgroundColor: .green)
                Text(morTaweesilpSpeech.hospitalizedString)
                    .defailtModifier(
                        alignment: .center,
                        font: .headline,
                        lineLimit: 3,
                        maxHeight: .infinity,
                        padding: EdgeInsets(
                            top: .extraSmall,
                            leading: .extraSmall,
                            bottom: .extraSmall,
                            trailing: .extraSmall),
                        backgroundColor: .orange)
            }
            .frame(
                maxHeight: .infinity)
            if family == .systemLarge
            {
                HStack(spacing: 0.0)
                {
                    Text(morTaweesilpSpeech.percentTestsString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            maxHeight: .infinity,
                            padding: EdgeInsets(
                                top: .extraSmall,
                                leading: .extraSmall,
                                bottom: .extraSmall,
                                trailing: .extraSmall),
                            backgroundColor: .yellow)
                    Text(morTaweesilpSpeech.percentCasesString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            maxHeight: .infinity,
                            padding: EdgeInsets(
                                top: .extraSmall,
                                leading: .extraSmall,
                                bottom: .extraSmall,
                                trailing: .extraSmall),
                            backgroundColor: .red)
                }
                .frame(
                    maxHeight: .infinity)
                HStack(spacing: 0.0)
                {
                    Text(morTaweesilpSpeech.oneCasePerPeopleString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            maxHeight: .infinity,
                            padding: EdgeInsets(
                                top: .extraSmall,
                                leading: .extraSmall,
                                bottom: .extraSmall,
                                trailing: .extraSmall),
                            backgroundColor: .orange)
                    Text(morTaweesilpSpeech.oneDeathPerPeopleString)
                        .defailtModifier(
                            alignment: .center,
                            font: .headline,
                            lineLimit: 1,
                            maxHeight: .infinity,
                            padding: EdgeInsets(
                                top: .extraSmall,
                                leading: .extraSmall,
                                bottom: .extraSmall,
                                trailing: .extraSmall),
                            backgroundColor: .black)
                }
                .frame(
                    maxHeight: .infinity)
            }
        }
    }
}

struct CoconutMilk_Previews: PreviewProvider
{
    static var previews: some View
    {
        CoconutMilk(
            morTaweesilpSpeech: MorTaweesilpSpeech(
                todayCases: -1,
                todayDeaths: -1,
                recovered: -1,
                todayRecovered: -1,
                active: -1,
                newHospitalized: -1,
                cases: -1,
                deaths: -1,
                tests: -1,
                population: -1,
                oneCasePerPeople: -1,
                oneDeathPerPeople: -1,
                updated: Date()))
            .previewContext(
                WidgetPreviewContext(
                    family: .systemSmall))
    }
}

@main
struct PrayuthJunior: Widget
{
    let kind: String = "Main"
    
    // MARK: - Presenter
    
    @ObservedObject private var anutin = Anutin(morTaweesilpSpeech: nil)
    
    // MARK: -
    
    var body: some WidgetConfiguration
    {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: anutin) { morTaweesilpSpeech in
                CoconutMilk(
                    morTaweesilpSpeech: morTaweesilpSpeech) }
            .configurationDisplayName("COVID-19 TH")
            .description("Diary COVID-19 Stat of TH.")
    }
}
