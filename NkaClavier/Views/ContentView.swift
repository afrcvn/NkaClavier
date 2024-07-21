//
//  ContentView.swift
//  NkaClavier
//
//  Created by Samba Diawara on 2024-06-03.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var screen: Screen? = .first
    var player1 = AVPlayer(url: Bundle.main.url(forResource: "demo1", withExtension: "mp4")!)
    var player2 = AVPlayer(url: Bundle.main.url(forResource: "demo2", withExtension: "mp4")!)
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal)  {
                HStack(spacing: 0) {
                    ForEach(Screen.allCases, id: \.self) { screen in
                        VStack {
                            switch screen {
                            case .first:
                                screen1()
                            case .seconde:
                                VideoScreen(
                                    title: "Comment ajouter un clavier?",
                                    player: player1,
                                    footer: "Réglages → Général → Clavier → Claviers → Ajouter un clavier → Nka Clavier"
                                )
                            case .thirsd:
                                VideoScreen(
                                    title: "Comment utiliser un clavier?",
                                    player: player2,
                                    footer: Text("Appuyez sur \(Image(systemName: "globe")) en bas à gauche de votre clavier pour basculer entre les claviers.")
                                )
                                
                            case .fourth:
                                screen4()
                            }
                        }
                        .clipShape(.rect(cornerRadius: 30))
                        .padding(.horizontal, 3)
                        .frame(width: proxy.size.width)
                        .scrollTransition { effect, phase in
                            effect.scaleEffect(1-abs(phase.value)*0.25, anchor: phase.value > 0 ? .leading : .trailing)
                                .offset(x: -phase.value*50)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $screen)
            .scrollIndicators(.hidden)
            .frame(width: proxy.size.width)
            .scrollClipDisabled()
            .scrollTargetBehavior(.paging)
        }
        .onChange(of: screen, initial: true, playStop)
    }
    
    func screen1() -> some View {
        VStack(spacing: 15) {
            Typewriter2(texts: ["Bamanankan →", "Soninkaxane →", "→ ߒߞߏ"], cursor: .init(String.zeroWidth), speed: 0.01, delay: 2)
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.blue.gradient)
            Text("Notre mission est de vous offrir des claviers adaptés à certaines langues  parlées en Afrique.")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.horizontal, 70)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxHeight: .infinity)
    }
    
    func screen4() -> some View {
        VStack {
            Text("politique de confidentialité")
                .font(.headline)
            
            VStack(spacing: 10) {
                Text("La protection de données personnelles est un aspect essentiel que nous prenons au sérieux.")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                ForEach(InfoItem.privacy, content: InfoItemView.init(item:))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            .padding(.leading, 40)
            .padding(.trailing)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func playStop() {
        DispatchQueue.main.async {
            switch screen {
            case .seconde:
                player1.play()
                player2.seek(to: .zero)
                player2.pause()
            case .thirsd:
                player2.play()
                player1.seek(to: .zero)
                player1.pause()
            default:
                player1.seek(to: .zero)
                player2.seek(to: .zero)
                player1.pause()
                player2.pause()
            }
        }
    }
}

extension String {
    public static var zeroWidth: String { "\u{200E}" }
}

#Preview {
    ContentView()
}
