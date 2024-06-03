import SwiftUI

struct InfoItemView: View {
    let item: InfoItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: item.systemImage)
                .font(.title)
                .frame(width: 30)
                //.foregroundStyle(Color.accentColor)

            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.headline)
                Text(item.description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    InfoItemView(item: .preview)
}
