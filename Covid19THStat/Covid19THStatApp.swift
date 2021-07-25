//
//  Covid19THStatApp.swift
//  Covid19THStat
//
//  Created by Wipoo Shinsirikul on 28/7/21.
//

import SwiftUI

@main
struct Covid19THStatApp: App
{
    var body: some Scene
    {
        WindowGroup
        {
            Prayuth(
                anutin: Anutin(
                    morTaweesilpSpeech: nil))
        }
    }
}
