import SwiftUI

struct HomeHeader: View {
    @StateObject var authViewModel = AuthViewModel()
    @State var name = ""
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                HStack(){
                    Text("Hello")
                        .fontWeight(.semibold)
                        .font(.system(size: 33))
                    NavigationLink(destination: getDestination(isLoged: authViewModel.isUserLogedIn)
                    ){
                        if authViewModel.isUserLogedIn {
                            Text(name)
                                .fontWeight(.semibold)
                                .font(.system(size: 33))
                        } else {
                            Text("SignIn")
                                .fontWeight(.semibold)
                                .font(.system(size: 33))
                        }
                    }
                }
                Text("Find best recipe for today!")
            }
            Spacer()
        }.padding(.horizontal)
            .onAppear{
                        let defaults = UserDefaults.standard
                        if let user = defaults.object(forKey: "userDetails") as? Data {
                            let decoder = JSONDecoder()
                            if let loadedUser = try? decoder.decode(UserDetails.self, from: user) {
                                name = loadedUser.fullName
                            }
                        }
                    }
    }
    
    func getDestination(isLoged: Bool) -> AnyView {
            if isLoged {
                return AnyView(ProfileView());
            } else {
                return AnyView(LoginView());
            }
        }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader()
    }
}
