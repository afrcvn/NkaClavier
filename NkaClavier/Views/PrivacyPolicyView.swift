import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        PopButton("Politique de Confidentialité") { isPresented in
            content()
        }
    }
    
    func content() -> some View {
        PopoverContainer {
            VStack(spacing: 0) {
                HStack {
                    Text("Politique de Confidentialité")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        ForEach(1..<6) { _ in
                            BlurEffect(effect: .removeAll)
                                .blur(radius: 15)
                        }
                    }
                )
                .zIndex(2)

                ScrollView {
                    ZStack {
                        background()
                        itemsList()
                    }
                }
                .scrollClipDisabled()
                .zIndex(1)
            }
        }
    }
    
    func itemsList() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(InfoItem.privacy, content: InfoItemView.init(item:))
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.horizontal)
    }
    
    func background() -> some View {
        Color.clear
            .containerRelativeFrame([.vertical], alignment: .center)
    }
}

#Preview {
    VStack {
        Spacer()
        PrivacyPolicyView()
    }
}
