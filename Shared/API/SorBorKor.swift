//
//  SorBorKor.swift
//  Covid19THStat
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import Combine
import Foundation

final class SorBorKor
{
    // MARK: - Properties
    
    private let baseURL: URL
    
    private var decoder: JSONDecoder
    {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
        return jsonDecoder
    }
    
    // MARK: - Initializer
    
    init(baseUrl: URL)
    {
        self.baseURL = baseUrl
    }
}

extension SorBorKor
{
    func speech() -> AnyPublisher<MorTaweesilpSpeech, Error>
    {
        let resource = SorBorKor.Resources.todayCases
        
        var request = URLRequest(url: baseURL.appendingPathComponent(resource.path))
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = nil
        
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MorTaweesilpSpeech.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

extension SorBorKor
{
    enum Resources
    {
        case todayCases
    }
}

extension SorBorKor.Resources
{
    var path: String
    {
        switch self
        {
            case .todayCases:
                return "getTodayCases.json"
        }
    }
    
    var httpMethod: HTTPMethod
    {
        switch self
        {
            case .todayCases:
                return .get
        }
    }
}

