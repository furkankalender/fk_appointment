class CurrentUser {
    static let shared = CurrentUser()
    
    var userID: String?
    var userName: String?
    var userSurname: String?
    var userEmail: String?
    var userLocation: String?
    
    private init() {}
    
    func setUserID(_ userID: String) {
        self.userID = userID
    }
    func setUserName(userName: String) {
        self.userName = userName
    }
    func setUserSurname (userSurname: String){
        self.userSurname = userSurname
    }
    func setUserEmail(userEmail: String) {
        self.userEmail = userEmail
    }
    func setUserLocaiton(userLocation: String){
        self.userLocation = userLocation
    }
}



