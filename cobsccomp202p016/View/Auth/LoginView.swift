import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack(alignment: .center){
            Image("App_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .padding(.bottom, 0)
            Text("Welcome Back!")
                .font(.system(size: 32))
                .padding(.top, 0)
                .font(Font.title.weight(.bold))
                .padding(.bottom, 0)
            Text("login to continue")
                .font(.system(size: 18))
                .padding(.top, 0)
                .padding(.bottom, 10)
            
            InputTextField(title: "Email", value: $email)
            InputPasswordField(title: "Password", value: $password)
            Text(authViewModel.errorMsg)
                .font(.system(size: 14))
                .foregroundColor(.pink)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Button(action: {
                authViewModel.signIn(email: email, password: password)
               }) {
                   if authViewModel.isLoadingActive {
                        VStack(alignment: .center) {
                            Spacer()
                            ProgressView()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.orange)
                                Spacer()
                            }.foregroundColor(Color(
                                UIColor(named:"PrimaryBackgroundColor")!))
                                .frame(width: 250, height: 50)
                                .background(Color(UIColor(named: "PrimaryAppColor")!))
                                .cornerRadius(8)
                                   
                    } else {
                        Text("Continue")
                            .frame(minWidth: 0, maxWidth: 200)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
               }
               .background(Color.green) // If you have this
               .cornerRadius(12)
               .padding(.top)
            HStack{
                Text("Don't have an account?")
                NavigationLink(destination: RegisterView()){
                    Text("Register")
                }
            }
        }.padding(.horizontal)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
