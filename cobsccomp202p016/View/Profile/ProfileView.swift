import SwiftUI

struct ProfileView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack(alignment: .center){
            InputTextField(title: "Full Name", value: $firstName)
            InputTextField(title: "Email", value:  $email)
            HStack(){
                Button(action: {
                    authViewModel.signOut();
                }){
                    Text("Logout")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 1)
                        )
                }
                
                NavigationLink(destination: LoginView()){
                    Text("Update")
                        .frame(minWidth: 0, maxWidth: 200)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 2)
                    ).background(Color.green) // If you have this
                        .cornerRadius(12)
                       
                }
                
            }.padding(.top)
            Spacer()
        }
        .padding(.top, 50)
        .padding(.horizontal)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
//                    let defaults = UserDefaults.standard
//                    if let user = defaults.object(forKey: "userDetails") as? Data {
//                        let decoder = JSONDecoder()
//                        if let loadedUser = try? decoder.decode(UserDetails.self, from: user) {
//                            firstName = loadedUser.firstName
//                            lastName = loadedUser.lastName
//                            email = loadedUser.email
//                        }
//                    }
                }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
