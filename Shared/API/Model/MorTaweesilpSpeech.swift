//
//  MorTaweesilpSpeech.swift
//  Covid19THStat
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import WidgetKit
import Foundation

struct MorTaweesilpSpeech: Hashable, Codable
{
    /*
     {
       "updated": 1627406010270,
       "country": "Thailand",
       "cases": 526828,
       "todayCases": 14150,
       "deaths": 4264,
       "todayDeaths": 118,
       "recovered": 350643,
       "todayRecovered": 9168,
       "active": 171921,
       "critical": 4284,
       "casesPerOneMillion": 7528,
       "deathsPerOneMillion": 61,
       "tests": 8129670,
       "testsPerOneMillion": 116160,
       "population": 69986824,
       "continent": "Asia",
       "oneCasePerPeople": 133,
       "oneDeathPerPeople": 16413,
       "oneTestPerPeople": 9,
       "activePerOneMillion": 2456.48,
       "recoveredPerOneMillion": 5010.13,
       "criticalPerOneMillion": 61.21,
       "Confirmed": 526828,
       "Recovered": 350643,
       "Hospitalized": 171921,
       "Deaths": 4264,
       "NewConfirmed": 14150,
       "NewRecovered": 9168,
       "NewHospitalized": 4864,
       "NewDeaths": 118,
       "UpdateDate": "28/07/2021 00:13",
       "DevBy": "SUNDAY TECHNOLOGIES"
     }
     */
    let todayCases: Int
    let todayDeaths: Int
    let recovered: Int
    let todayRecovered: Int
    let active: Int
    let newHospitalized: Int
    let cases: Int
    let deaths: Int
    let tests: Int
    let population: Int
    let oneCasePerPeople: Int
    let oneDeathPerPeople: Int
    let updated: Date
}

extension MorTaweesilpSpeech: TimelineEntry
{
    var date: Date { return updated }
    var relevance: TimelineEntryRelevance? { return TimelineEntryRelevance(score: Float(date.timeIntervalSince1970), duration: 0.0) }
}

extension MorTaweesilpSpeech
{
    var dateFormatter: DateFormatter
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE dd MMM, HH:mm"
        
        return formatter
    }
    
    var numberFormatter: NumberFormatter
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }
    
    var casesString: String { return "🤒\n\(numberFormatter.string(for: cases) ?? "\(cases)")\n(+ \(numberFormatter.string(for: todayCases) ?? "\(todayCases)"))" }
    var deathsString: String { return "🪦\n\(numberFormatter.string(for: deaths) ?? "\(deaths)")\n(+ \(numberFormatter.string(for: todayDeaths) ?? "\(todayDeaths)"))" }
    var recoveredString: String { return "🤕\n\(numberFormatter.string(for: recovered) ?? "\(recovered)")\n(+ \(numberFormatter.string(for: todayRecovered) ?? "\(todayDeaths)"))" }
    var hospitalizedString: String { return "🏥\n\(numberFormatter.string(for: active) ?? "\(active)")\n(+ \(numberFormatter.string(for: newHospitalized) ?? "\(newHospitalized)"))" }
    var percentTestsString: String { return "🩺/👨‍👩‍👧‍👦 " + (numberFormatter.string(for: 100.0 * (Double(tests) / Double(population))) ?? "\(100.0 * (Double(tests) / Double(population)))") + "%" }
    var percentCasesString: String { return "🤒/🩺 " + (numberFormatter.string(for: 100.0 * (Double(cases) / Double(tests))) ?? "\(100.0 * (Double(cases) / Double(tests)))") + "%" }
    var oneCasePerPeopleString: String { return "🤒/👨‍👩‍👧‍👦 " + (numberFormatter.string(for: oneCasePerPeople) ?? "\(oneCasePerPeople)") }
    var oneDeathPerPeopleString: String { return "🪦/👨‍👩‍👧‍👦 " + (numberFormatter.string(for: oneDeathPerPeople) ?? "\(oneDeathPerPeople)") }
    var updatedString: String { return "📅 " + dateFormatter.string(from: updated) }
}

extension MorTaweesilpSpeech
{
    enum CodingKeys: String, CodingKey
    {
        case todayCases
        case todayDeaths
        case recovered
        case todayRecovered
        case active
        case newHospitalized = "NewHospitalized"
        case cases
        case deaths
        case tests
        case population
        case updated
        case oneCasePerPeople
        case oneDeathPerPeople
    }
}
