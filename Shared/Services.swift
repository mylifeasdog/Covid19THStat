//
//  Services.swift
//  Covid19THStat
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import Foundation

final class Services
{
    static let `default` = Services()
    
    // MARK: - Properties
    
    let sorBorKor: SorBorKor
    
    init()
    {
        guard let baseURL = URL(string: "https://static.easysunday.com/covid-19/") else
        {
            fatalError()
        }
        
        sorBorKor = SorBorKor(baseUrl: baseURL)
    }
}
