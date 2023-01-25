import SwiftUI

struct InputPasswordField: View {
    var title:String
    @Binding var value:String
    
    var body: some View {
        SecureField(title,
                    text: $value)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0)))
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
}

struct InputPasswordField_Previews: PreviewProvider {
    @State static var password:String = ""
    static var previews: some View {
        InputPasswordField(
            title: "Input Password Field",
            value: $password
        )
    }
}
