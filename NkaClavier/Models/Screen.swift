//
//  File.swift
//  NkaClavier
//
//  Created by Samba Diawara on 2024-07-21.
//

import AVFoundation

enum Screen: Int, CaseIterable, Hashable, Identifiable {
    case first, seconde, thirsd, fourth
    var id: Self { self }
}
