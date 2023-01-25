import SwiftUI

struct HomeCarousel: View {
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        ZStack {
            ForEach(store.items) { item in
                Image(item.title)
                    .resizable()
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange, lineWidth: 0))
                    .frame(width:UIScreen.main.bounds.width-50,height: 220)
                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                    .opacity(1.0 - abs(distance(item.id)) * 0.2 )
                    .offset(x: myXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            draggingItem = snappedItem + value.translation.width / 100
                        }
                        .onEnded { value in
                            withAnimation {
                                draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                                draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                                snappedItem = draggingItem
                            }
                        }
                )
    }
    
    func distance(_ item: Int) -> Double {
            return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
        }
        
        func myXOffset(_ item: Int) -> Double {
            let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
            return sin(angle) * 200
        }
}

struct Item: Identifiable {
    var id: Int
    var title: String
}

class Store: ObservableObject {
    @Published var items: [Item]
    let images: [String] = ["Banner_1", "Banner_2", "Banner_3"]
    init() {
        items = []
        for i in 0...2 {
            let new = Item(id: i, title: images[i])
            items.append(new)
        }
    }
}


struct HomeCarousel_Previews: PreviewProvider {
    static var previews: some View {
        HomeCarousel()
    }
}
