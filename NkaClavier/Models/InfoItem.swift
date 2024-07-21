import SwiftUI

struct InfoItem: Identifiable {
    let id = UUID()
    let title: LocalizedStringKey
    let systemImage: String
    let description: LocalizedStringKey

    init(
        _ title: LocalizedStringKey,
        systemImage: String,
        description: LocalizedStringKey
    ) {
        self.title = title
        self.description = description
        self.systemImage = systemImage
    }
}

extension InfoItem {
    static let privacy: [InfoItem] = [
        InfoItem(
            "Aucune Collecte de Données",
            systemImage: "info",
            description: "Nous ne collectons aucune information personnelle, technique ou autre. Nous ne recueillons ni ne stockons aucune donnée vous concernant."
        ),
        InfoItem(
            "Utilisation des Informations",
            systemImage: "apps.iphone.badge.plus",
            description: "Puisque nous ne collectons aucune donnée, il n'y a aucune information à utiliser. Votre expérience utilisateur est entièrement anonyme et privée."
        ),
        InfoItem(
            "Protection de la Vie Privée",
            systemImage: "lock.shield.fill",
            description: "Bien que nous ne recueillions aucune donnée, nous nous engageons à protéger votre vie privée. Nous ne partagerons, ne vendrons, ni ne louerons aucune information vous concernant à des tiers."
        ),
        InfoItem(
            "Vos Droits",
            systemImage: "building.columns.fill",
            description: "Vous conservez tous les droits liés à votre vie privée. Si vous avez des questions ou des préoccupations, n'hésitez pas à nous contacter à team@afrcvn.com."
        ),
        InfoItem(
            "Modifications",
            systemImage: "point.bottomleft.filled.forward.to.point.topright.scurvepath",
            description: "Bien que cette politique de confidentialité indique que nous ne collectons aucune donnée, nous nous réservons le droit de la mettre à jour si nécessaire. Nous vous tiendrons informés des changements le cas échéant."
        )
    ]
}
