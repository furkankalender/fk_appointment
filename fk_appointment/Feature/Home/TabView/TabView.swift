import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ForEach(HomeTabItem.tabItems) {
                item in
                item.page.tabItem {
                    TabIconLabel(model: item.model).navigationBarHidden(true)
                }
            }
        }.accentColor(.peach).padding(.horizontal,0).navigationBarHidden(true)   }
}


private struct TabIconLabel: View {
    let model: TabModel
    var body: some View {
        VStack {
            Image(model.icon.rawValue)
            Text(model.title.rawValue.locale())
        }.navigationBarHidden(true)
    }
}
