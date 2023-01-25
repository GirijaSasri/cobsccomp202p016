import SwiftUI

struct HomeSearchBar: View {
    @State private var text: String = ""
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $text)
        }
            .padding(.leading)
            .padding(.top)
            .padding(.bottom)
        .background(Color.white)
        .cornerRadius(12.0)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
//                .inset(by: 5)
                .stroke(.black, lineWidth: 1)
        )
        .padding(.trailing, 0)
            NavigationLink(destination: FavouriteView()){
                Image(systemName: "heart.fill")
                        .font(.system(size: 28))
                    .foregroundColor(Color(UIColor(named: "PrimaryBackgroundColor")!))
                    .padding(.all, 10)
                    .background(Color(UIColor(named: "PrimaryAppColor")!))
                    .cornerRadius(12.0)
            }
        
                    
        }.frame(height: 54)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct HomeSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchBar()
    }
}

