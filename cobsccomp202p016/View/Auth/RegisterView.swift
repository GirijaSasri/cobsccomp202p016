import SwiftUI

struct RegisterView: View {
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack(){
            Image("App_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .padding(.bottom, 0)
            Text("Create an Account")
                .font(.system(size: 32))
                .padding(.top, 0)
                .font(Font.title.weight(.bold))
                .padding(.bottom, 0)
            Text("register with your email address")
                .font(.system(size: 18))
                .padding(.top, 0)
                .padding(.bottom, 10)
            
            InputTextField(title: "Full Name", value: $fullName)
            InputTextField(title: "Email", value: $email)
            InputPasswordField(title: "Password", value: $password)
            InputPasswordField(title: "Confirm Password", value: $confirmPassword)
            Text(authViewModel.errorMsg)
                .font(.system(size: 14))
                .foregroundColor(.pink)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)

            Button(action: {
                if(password != confirmPassword){
                    authViewModel.errorMsg = "Password not match!"
                } else {
                    authViewModel.signUp(user: UserDetails(fullName: fullName, email: email), password: password, confirmPassword: password)
                }
               }) {
                   if authViewModel.isLoadingActive {
                        VStack(alignment: .center) {
                            Spacer()
                            ProgressView()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                Spacer()
                            }
                        .foregroundColor(.white)
                                .frame(width: 250, height: 50)
                                .background(Color.green)
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
               .background(Color.green)
               .cornerRadius(12)
               .padding(.top)
        }.padding(.horizontal)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
