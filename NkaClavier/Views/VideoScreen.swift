//
//  File.swift
//  NkaClavier
//
//  Created by Samba Diawara on 2024-07-21.
//

import SwiftUI
import AVFoundation

struct VideoScreen: View {
    var title: String
    var player: AVPlayer
    var footer: String
    var footerText: Text?
    
    init(title: String, player: AVPlayer, footer: String, footerText: Text? = nil) {
        self.title = title
        self.player = player
        self.footer = footer
        self.footerText = footerText
    }
    
    init(title: String, player: AVPlayer, footer: Text) {
        self.title = title
        self.player = player
        self.footer = ""
        self.footerText = footer
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            
            VideoPlayerView(player: player)
                .clipShape(.rect(cornerRadius: 40))
                .padding(2)
                .overlay(.placeholder, in: .rect(cornerRadius: 43).stroke(lineWidth: 4))
                .overlay(alignment: .bottom) {
                    Group {
                        if let footerText {
                            footerText
                        } else {
                            Text(footer)
                        }
                    }
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                        .offset(y: 50)
                        .font(.footnote)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                }
                .aspectRatio(1179/2556, contentMode: .fit)
                .safeAreaPadding(.bottom, 50)
    
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }

    }
}
