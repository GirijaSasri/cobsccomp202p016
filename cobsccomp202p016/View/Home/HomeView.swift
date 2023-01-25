import SwiftUI

struct HomeView: View {
    @StateObject var recipeViewModel = RecipeViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(named:"PrimaryBackgroundColor")!)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack{
                        HomeHeader()
                        HomeSearchBar()
                            .padding(.bottom, 5)
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HomeCarousel()
                                .padding(.horizontal)
                                .padding(.bottom)
                            if !recipeViewModel.isLoadingActive {
                                VStack {
                                    HomeRecipeSlider(
                                        title: "Popular Recipe"
                                    )
                                    HomeRecipeSlider(
                                        title: "Latest Recipe"
                                    )
                                }
                            }
                            Spacer()
                        }
                    }.padding(.top, 5)
                }
                .padding(.top, 10)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
