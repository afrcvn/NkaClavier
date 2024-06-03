//
//  ContentView.swift
//  NkaClavier
//
//  Created by Samba Diawara on 2024-06-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ZStack {
                    Color.clear
                        .containerRelativeFrame([.vertical], alignment: .center)

                    VStack(alignment: .leading, spacing: 30) {
                        
                        VStack(alignment: .leading, spacing: 30) {
                            header()
                            tipview()
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Langues actuellement supportées")
                                .font(.headline)
                            
                            ForEach(InfoItem.supportedLanguages) { language in
                                VStack(alignment: .leading) {
                                    Text(language.title)
                                        .font(.subheadline)
                                    Text(language.description)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
            .scrollIndicators(.never)
            .scrollClipDisabled()

            infoview()
        }
        .background(Color(uiColor: .tertiarySystemGroupedBackground))
    }
    
    func header() -> some View {
        VStack {
            Text("Nka Clavier")
                .font(.largeTitle.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text("Notre mission est de vous offrir des claviers adaptés à certaines langues  parlées en Afrique.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
    
    func infoview() -> some View {
        VStack(spacing: 0) {
            Image(systemName: "lock.trianglebadge.exclamationmark.fill")
                .foregroundStyle(.primary, .secondary)
                .foregroundStyle(.blue)
                .imageScale(.large)
            Text("""
                La protection de vos données personnelles est un aspect essentiel que chacun doit prendre au sérieux. Afin de garantir une expérience sécurisée et transparente, nous vous encourageons vivement à examiner attentivement notre politique de confidentialité concernant vos données dans cette application. Vous y trouverez des détails sur la manière dont nous collectons, utilisons et sécurisons vos informations personnelles.
                """
            )
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            PrivacyPolicyView()
                .foregroundStyle(.blue)
                .font(.caption)
                .padding(.top)
        }
        .padding(.horizontal)
        .padding(.top, 5)
        .frame(maxWidth: .infinity)
        .background(BlurEffect().ignoresSafeArea())
    }
    
    func tipview() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Pour activer, veuillez suivre les instructions suivantes :")
                .font(.footnote)
                .foregroundStyle(.secondary)
            

            Typewriter(text: """
                       Réglages ➤ Général ➤ Clavier ➤ Claviers ➤
                       Ajouter un clavier ➤ Nka Clavier
                       """, cursor: "|", speed: 0.01)
                .fontDesign(.rounded)
                .font(.callout)
                .foregroundStyle(.blue)
                .frame(height: 70)
            
            
            Text("Ensuite, lors de la saisie, appuyez sur \(Image(systemName: "globe")) en bas à droite de votre clavier pour basculer entre les claviers.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
        }
        .padding(5)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(BlurEffect())
        .background(.blue.opacity(0.1))
        .clipShape(.rect(cornerRadius: 5))
    }
}

#Preview {
    ContentView()
}
