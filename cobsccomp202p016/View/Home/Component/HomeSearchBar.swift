import SwiftUI

struct HomeSearchBar: View {
    @State private var text: String = ""
    @StateObject var authViewModel = AuthViewModel()
    
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
                .stroke(.black, lineWidth: 1)
        )
        .padding(.trailing, 0)
            NavigationLink(destination: getDestination(isLoged: authViewModel.isUserLogedIn)){
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
    
    func getDestination(isLoged: Bool) -> AnyView {
            if isLoged {
                return AnyView(FavouriteView());
            } else {
                return AnyView(LoginView());
            }
        }
}

struct HomeSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchBar()
    }
}

