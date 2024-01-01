import SwiftUI

struct SignUpView : View {
    @ObservedObject private var viewModel = SignUpViewModel()
    let  iconSize :CGFloat = 22
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                  
                    HTextIconField(hint: LocaleKeys.General.nameHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.nameValue,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                    HTextIconField(hint: LocaleKeys.General.surnameHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.surnameValue,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                    HTextIconField(hint: LocaleKeys.General.emailHint.rawValue.locale(), iconName: IconItems.mail, text: $viewModel.emailValue,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                    HTextSecureIconField(hint: LocaleKeys.General.passwordHint.rawValue.locale(), iconName: IconItems.lock, text: $viewModel.passwordValue ).padding(.top, PagePadding.All.normal.rawValue)
                }
                VStack{
                    HTextSecureIconField(hint: LocaleKeys.General.passwordAgainHint.rawValue.locale(), iconName: IconItems.lock, text: $viewModel.passwordAgainValue ).padding(.top, PagePadding.All.normal.rawValue)
                    HTextIconField(hint: LocaleKeys.General.cityHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.cityValue,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                    HTextIconField(hint: LocaleKeys.General.townHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.townValue,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                    HTextIconField(hint: LocaleKeys.General.neighborhoodHint.rawValue.locale(), iconName: IconItems.edit, text: $viewModel.neighborhoodValue,width: iconSize, height:iconSize ).padding(.top, PagePadding.All.normal.rawValue)
                    CustomDropDown(selectedValue: $viewModel.permissionValue, values: PermissionType.allCases){
                        newValue in viewModel.permissionValue = newValue
                    }
                   
                    NavigationLink("", isActive: $viewModel.isCreatedUser){
                        LoginView().navigationBarBackButtonHidden(true)
                    }
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: FontSizes.caption1, weight: .semibold))
                        .font(.system(size: FontSizes.title1, weight: .semibold))
                        .foregroundColor(.teflon)
                    NormalButton(onTap: {
                        Task {
                            await viewModel.onCreateUser()
                        }
                    }, title: LocaleKeys.Login.signIn.rawValue).padding(.top, PagePadding.All.normal.rawValue)
                    
                }.ignoresSafeArea()
            }  .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
              
        }
        .navigationBarTitle("", displayMode: .inline)  .navigationBarTitle("", displayMode: .inline)
        .edgesIgnoringSafeArea(.top)
        .padding(.horizontal, PagePadding.Horizontal.normal.rawValue)
    }
}
