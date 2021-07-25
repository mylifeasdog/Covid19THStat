//
//  Anutin.swift
//  Covid19THStat
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import Combine
import Foundation
import SwiftUI
import WidgetKit

private let UnderTable = DispatchQueue.global(qos: .background)
private let PublicAnnouncement = RunLoop.main

class Anutin: ObservableObject
{
    // MARK: - Properties
    
    @Published var isRefreshing = false
    @Published var morTaweesilpSpeech: MorTaweesilpSpeech
    
    // MARK: - Cancellable
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    init(
        morTaweesilpSpeech: MorTaweesilpSpeech?)
    {
        if let morTaweesilpSpeech = morTaweesilpSpeech
        {
            self.morTaweesilpSpeech = morTaweesilpSpeech
        }
        else if let morTaweesilpSpeech = Anutin.loadMorTaweesilpSpeech()
        {
            self.morTaweesilpSpeech = morTaweesilpSpeech
        }
        else
        {
            self.morTaweesilpSpeech = MorTaweesilpSpeech(
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
                updated: Date())
        }
        
        $morTaweesilpSpeech
            .receive(
                on: UnderTable)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    Anutin.save(morTaweesilpSpeech: $0) })
            .store(in: &cancellable)
    }
}

extension Anutin
{
    func reloadData()
    {
        isRefreshing = true
        
        Services
            .default
            .sorBorKor
            .speech()
            .receive(
                on: PublicAnnouncement)
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isRefreshing = false },
                receiveValue: { [weak self] in
                    self?.morTaweesilpSpeech = $0 })
            .store(in: &cancellable)
    }
}

extension Anutin
{
    private static var appGroupUserDefaults: UserDefaults?
    {
        return UserDefaults(suiteName: "IHereToogroup")
    }
    
    private static func save(morTaweesilpSpeech: MorTaweesilpSpeech)
    {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(morTaweesilpSpeech) else
        {
            return
        }
        
        appGroupUserDefaults?.set(data, forKey: "com.IHereToo.Covid19THStat.morTaweesilpSpeech")
    }
    
    private static func loadMorTaweesilpSpeech() -> MorTaweesilpSpeech?
    {
        guard let data = appGroupUserDefaults?.data(forKey: "com.IHereToo.Covid19THStat.morTaweesilpSpeech") else
        {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        return try? decoder.decode(MorTaweesilpSpeech.self, from: data)
    }
}

extension Anutin: IntentTimelineProvider
{
    func placeholder(in context: Context) -> MorTaweesilpSpeech
    {
        return morTaweesilpSpeech
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MorTaweesilpSpeech) -> ())
    {
        if context.isPreview
        {
            completion(morTaweesilpSpeech)
        }
        else
        {
            Services
                .default
                .sorBorKor
                .speech()
                .receive(on: PublicAnnouncement)
                .handleEvents(
                    receiveOutput: { [weak self] in
                        self?.morTaweesilpSpeech = $0 })
                .sink(
                    receiveCompletion: { _ in},
                    receiveValue: {
                        completion($0) })
                .store(in: &cancellable)
        }
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<MorTaweesilpSpeech>) -> ())
    {
        if context.isPreview
        {
            completion(
                Timeline(
                    entries: [ morTaweesilpSpeech ],
                    policy: .after(morTaweesilpSpeech.date.advanced(by: 4.hours))))
        }
        else
        {
            Services
                .default
                .sorBorKor
                .speech()
                .receive(on: PublicAnnouncement)
                .handleEvents(
                    receiveOutput: { [weak self] in
                        self?.morTaweesilpSpeech = $0 })
                .sink(
                    receiveCompletion: { _ in},
                    receiveValue: {
                        completion(
                            Timeline(
                                entries: [ $0 ],
                                policy: .after($0.date.advanced(by: 4.hours)))) })
                .store(in: &cancellable)
        }
    }
}
