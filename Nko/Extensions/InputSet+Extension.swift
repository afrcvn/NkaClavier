//
//  InputSet+Extension.swift
//  Nko
//
//  Created by Samba Diawara on 2024-07-21.
//

import Foundation
import KeyboardKit

public extension InputSet {
    
    static var nkoChar: InputSet {
        .init(rows: [
           .init(chars: "ߊߥߋߌߍߎߐߏߞߒ"),
           .init(chars: "ߗߘߙߛߜߝߓߔߟߑ"),
           .init(chars: "ߠߡߢߕߣߤߦߴ"),
        ])
    }
    
    static func nkoNumber(currency: String) -> InputSet {
        .init(rows: [
            .init(chars: "߀߉߈߇߆߅߄߃߂߁"),
            .init(chars: ["߶", "߷", "!", "؟", "ߺ", "߾", "߿", "߹", "߸", "߽"]),
            .init(chars: ".؛،:”")
        ])
    }
    
    static func nkoSymbolic(currencies: [String]) -> InputSet {
        .init(rows: [
            .init(chars: "[]{}%^*-+="),
            .init(chars: "_/\\|~<>()•"),
            .init(chars: ".@&$#")
        ])
    }
}
