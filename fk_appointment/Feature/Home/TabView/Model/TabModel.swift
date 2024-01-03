

import Foundation
import SwiftUI

struct HomeTabItem: Identifiable {
    let id = UUID()
    let page: AnyView
    let model: TabModel

    static let tabItems: [HomeTabItem] = [
        HomeTabItem(page: AnyView(HomeView().navigationBarHidden(true)), model: TabModel(title: .home, icon: .home)),
        HomeTabItem(page: AnyView(CreateAdvertisementView()), model: TabModel(title: .create, icon: .edit)),
        HomeTabItem(page: AnyView(FavoritesView()), model: TabModel(title: .wishlist, icon: .favorite)),
        HomeTabItem(page: AnyView(UserAccountInfo()), model: TabModel(title: .account, icon: .person))
    ]
}

struct TabModel {
    let title: LocaleKeys.TabView
    let icon: IconItems.TabView
}
