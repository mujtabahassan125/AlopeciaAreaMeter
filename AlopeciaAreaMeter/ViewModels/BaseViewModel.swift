//
//  BaseViewModel.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 18/03/2024.
//

import Foundation
import UIKit


class BaseViewModel {
    var resultReceived: Observable = Observable(false)
    var patientDataReceived: Observable = Observable(false)
   // var alertModel: Observable = Observable(AlertModel(message: "", isShown: false))
  //  var toast: Observable = Observable(AlertModel(message: "", isShown: false))
    var isLoaderShown: Observable = Observable(false)
    var isShimmering: Observable = Observable(true)
  //  var educationModel: Observable<EducationResponseModel?> = Observable(nil)
    
    var apisInExecution: Int = 0
    var apisInExecutionForShimmer: Int = 0
    
    func setLoader(apiExecuted: Bool) {
        self.apisInExecution = apiExecuted ? self.apisInExecution - 1 : self.apisInExecution + 1
        self.apisInExecution = max(self.apisInExecution, 0)
     //   Utilities.securePrint("\n\napis in execution count: \(self.apisInExecution)\n\n")
        let showLoader: Bool = self.apisInExecution > 0
        if !self.isLoaderShown.value {
            self.isLoaderShown.value = showLoader
            self.isShimmering.value = showLoader
        } else {
            if !showLoader {
                self.isLoaderShown.value = showLoader
                self.isShimmering.value = showLoader
            }
        }
    }
    func setLoaderOnly(apiExecuted: Bool) {
        self.apisInExecution = apiExecuted ? self.apisInExecution - 1 : self.apisInExecution + 1
        self.apisInExecution = max(self.apisInExecution, 0)
    //    Utilities.securePrint("\n\napis in execution count: \(self.apisInExecution)\n\n")
        let showLoader: Bool = self.apisInExecution > 0
        if !self.isLoaderShown.value {
            self.isLoaderShown.value = showLoader
        } else {
            if !showLoader {
                self.isLoaderShown.value = showLoader
            }
        }
    }
    func setShimmer(apiExecuted: Bool) {
        self.apisInExecutionForShimmer = apiExecuted ? self.apisInExecutionForShimmer - 1 : self.apisInExecutionForShimmer + 1
        self.apisInExecutionForShimmer = max(self.apisInExecutionForShimmer, 0)
     //   Utilities.securePrint("\n\napis in execution count: \(self.apisInExecutionForShimmer)\n\n")
        let showShimmer: Bool = self.apisInExecutionForShimmer > 0
        if !self.isShimmering.value {
            self.isShimmering.value = showShimmer
        } else {
            if !showShimmer {
                self.isShimmering.value = showShimmer
            }
        }
    }
    /*
    func getEducationData(module: String) {
        Utilities.getEducationData(module: module) { model, success in
            if success {
                self.educationModel.value = model
            }
        }
    }
    func getUnreadNotificationsCount(notificationsList: [InAppNotificationModel]?) -> Int {
        let unreadNotifications = notificationsList?.filter { model in
            !model.read
        }
        return (unreadNotifications?.count ?? 0)
    }
    func getIdentityToken(tokenRequest: IdentityTokenRequestModel, realmName: String = "", completion: @escaping (_ tokenObj: IdentityTokenResponseModel?, _ error: CustomError?) -> Void) {
        let tempUrl = "\(Singleton.shared.getIdentityServerBaseUrl())\(PatientApiEnpoints.getIdentityToken)"
        let apiUrl = String(format: tempUrl, realmName)
        let bodyParam = tokenRequest
        let headerFields = ["Content-Type": ApiKey.apiContentTypeFormUrlEnc]
        ApiClient<IdentityTokenRequestModel, IdentityTokenResponseModel>.executePostRequest(fromUrl: apiUrl, bodyParameters: bodyParam, requestParameters: EmptyModel(), headerFields: headerFields) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                Utilities.securePrint(response.accessToken ?? "")
                completion(response, nil)
            case .failure(let error):
                Utilities.securePrint(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    func refreshToken(completion: @escaping (_ success: Bool, _ error: CustomError?) -> Void) {
        guard let patientDetails = Singleton.shared.patientDetails, let email = patientDetails.getValueFromTelecom(field: ProfileTelecomTypes.email) else { return }
        let bodyParam = IdentityTokenRequestModel(clientId: AppConstants.KEY_CLOAK_CLIENT_ID, grantType: "password", userName:  email, password: patientDetails.password?.value ?? "", scope: "openid", clientSecret: AppConstants.KEY_CLOAK_SECRET)
        self.getIdentityToken(tokenRequest: bodyParam) { tokenObj, error in
            if let token = tokenObj {
                completion(true, error)
            } else {
                completion(false, error)
            }
        }
    }
 x
    func getClientIdentityToken(completion: @escaping (_ success: Bool, _ error: CustomError?) -> Void) {
        if !Utilities.checkIdentityTokenExpired(tokenType: Constants.clientTokenDataKey) {
            if Singleton.shared.clientIdentityToken == nil {
                Singleton.shared.clientIdentityToken = Utilities.fetchIdentityTokenData(tokenType: Constants.clientTokenDataKey)
            }
            if Singleton.shared.sessionId == nil {
                self.setLoader(apiExecuted: false)
                Singleton.shared.getUserSession(isFirstSession: true) { [weak self] _, _ in
                    self?.setLoader(apiExecuted: true)
                    completion(true, nil)
                }
            } else {
                completion(true, nil)
            }
            return
        }
        let client_secret = Singleton.shared.getEnvironment() == ApiKey.devURL ? AppConstants.KEY_CLOAK_STAGING_CLIENT_SECRET : AppConstants.KEY_CLOAK_PROD_CLIENT_SECRET
        let realmName = Singleton.shared.getEnvironment() == ApiKey.devURL ? AppConstants.KEY_CLOAK_STAGING_REALM : AppConstants.KEY_CLOAK_PROD_REALM
        let bodyParam = IdentityTokenRequestModel(clientId: AppConstants.KEY_CLOAK_IOS_CLIENT_ID, grantType: "client_credentials", userName: "", password: "", scope: "openid", clientSecret: client_secret)
        
        self.setLoaderOnly(apiExecuted: false)
        self.getIdentityToken(tokenRequest: bodyParam, realmName: realmName) { [weak self] tokenObj, error in
            if tokenObj != nil {
                Singleton.shared.clientIdentityToken = tokenObj
                let date = Utilities.getCurrentDate()
                Singleton.shared.clientIdentityToken?.accessTokenExpirationDate = date.advanced(by: TimeInterval(Int(tokenObj?.expiresIn ?? 0)))
                Utilities.saveTokenDataToUserDefault(key: Constants.clientTokenDataKey, tokenObj: Singleton.shared.clientIdentityToken)
                if Singleton.shared.sessionId == nil {
                    Singleton.shared.getUserSession { _, _ in
                        self?.setLoaderOnly(apiExecuted: true)
                        completion(true, error)
                    }
                } else {
                    self?.setLoaderOnly(apiExecuted: true)
                    completion(true, error)
                }
                
            } else {
                self?.setLoaderOnly(apiExecuted: true)
                completion(false, error)
            }
        }
    }
    func getPatientDetailsWithIdentifier(shouldShowAlert: Bool = true, completion: @escaping (_ success: Bool, _ error: CustomError?) -> Void) {
        let userId = Utilities.getPatientIdentifierFromTokenClaims()
        Utilities.securePrint("\n\nClaim UserId is: \(userId )\n\n\n")
        
        let apiUrl = "\(Singleton.shared.getBaseUrl(portNumber: nil))\(PatientApiEnpoints.getPatientDetailsByIdentifier)"
        let headerFields = ["Authorization": Singleton.shared.getBearerAccessToken()]
        let bodyParams = [GetPatientDetailsByIdentifierRequestModel(system: AppConstants.IDENTITY_SYSTEM_NAME, value: userId)]
        ApiClient<[GetPatientDetailsByIdentifierRequestModel], PatientDetailsResponseModel>.executePostRequest(fromUrl: apiUrl, bodyParameters: bodyParams, requestParameters: EmptyModel(), headerFields: headerFields) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                Utilities.securePrint(response.id ?? "")
                Singleton.shared.patientDetails = response
                setupProfileComponents(profileModel: response)
                self.registerDeviceToken()
                Singleton.shared.getUserSession(isFirstSession: false, completion: nil)
                self.getFamilyAccessList {
                    self.patientDataReceived.value = true
                    completion(true, nil)
                }
//                self.patientDataReceived.value = true
//                completion(true, nil)
            case .failure(let error):
                Utilities.securePrint(error)
                self.patientDataReceived.value = false
                var errorMessage = ApiKey.somethingWrongErrorMessage
                if error.noContent {
                    errorMessage = Localizable.noPatientFoundMessage
                }
                self.alertModel.value.setValues(title: Localizable.error, message: errorMessage, isShown: shouldShowAlert)
                completion(false, error)
            }
        }
    }
    
    func setupProfileComponents(profileModel: PatientDetailsResponseModel?) {
        Singleton.shared.profileComponents.value.removeAll()
        let component = ProfileDetailComponent(title: ProfileEnum.email.rawValue.localizedString(), value: profileModel?.getValueFromTelecom(field: ProfileTelecomTypes.email) ?? "")
        if component.value != ""{
            Singleton.shared.profileComponents.value.append(component)
        } else {
            let component = ProfileDetailComponent(title: ProfileEnum.email.rawValue.localizedString(), value: profileModel?.getValueFromTelecom(field: "email") ?? "")
            Singleton.shared.profileComponents.value.append(component)
        }
    }
    
    func setupProfilesList(profileList: [FamilyAccessListResponseModel]?) {
        Singleton.shared.profilesList.value.removeAll()
        var patientProfile = SelectProfileModel(patientDetails: Singleton.shared.patientDetails, image: "profileDefaultIcon")
        patientProfile.isSelected = (Singleton.shared.selectedProfile.value?.id == patientProfile.id)
        Singleton.shared.profilesList.value.append(patientProfile)
        guard let profileList = profileList else {return}
        for profile in profileList {
            let profile = SelectProfileModel(id: profile.id, name: PatientName(givenName: Utilities.getValueAtZeroIndex(profile.name)?.given?[0], familyName: Utilities.getValueAtZeroIndex(profile.name)?.family, fullName: Utilities.getValueAtZeroIndex(profile.name)?.text), image: "profileDefaultIcon", isSelected: (profile.id == Singleton.shared.selectedProfile.value?.id))
            Singleton.shared.profilesList.value.append(profile)
        }
        // setSelectedIndex()
        // self.resultReceived.value = true
    }

    func logoutKeyCloak(delegate: UIViewController, completion: @escaping (_ success: Bool, _ error: CustomError?) -> Void) {
        guard let configuration = Singleton.shared.keyCloakConfig else { return }
        guard let authState = Singleton.shared.leapIdentityToken else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Utilities.securePrint("Error accessing AppDelegate")
            return
        }
        let redirectURI = URL(string: AppConstants.KEY_CLOAK_REDIRECT_URI)!
        let userAgent = OIDExternalUserAgentIOS(presenting: delegate, prefersEphemeralSession: true)
        let logoutRequest = OIDEndSessionRequest(configuration: configuration, idTokenHint: authState.idToken ?? "", postLogoutRedirectURL: redirectURI, state: authState.state ?? "", additionalParameters: nil)
        
        appDelegate.currentLogoutFlow = OIDAuthorizationService.present(logoutRequest, externalUserAgent: userAgent!) { [weak self] response, error in
            
            guard response != nil else {
                Utilities.securePrint("Error logging out Keycloak: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                let error = CustomError(description: error?.localizedDescription ?? "DEFAULT_KC_ERROR", unAuthorized: false)
                completion(false, error)
                return
            }
            self?.deleteDeviceToken()
            self?.resetToken()
            completion(true, nil)
        }
    }
    func resetToken() {
        UserDefaults.standard.removeObject(forKey: Constants.identityDataKey)
        Singleton.shared.leapIdentityToken = nil
        Singleton.shared.patientDetails = nil
    }
    func getFamilyAccessList(completion: @escaping() -> Void) {
        let tempUrl = "\(Singleton.shared.getBaseUrl(portNumber: nil))\(PatientApiEnpoints.getAccessUser)"
        let apiUrl = String(format: tempUrl, Singleton.shared.patientDetails?.id ?? "")
        let headerFields = ["Authorization": Singleton.shared.getBearerAccessToken(), "Content-Type": ApiKey.apiContentTypeJsonPatch]
        
        ApiClient<EmptyModel, [FamilyAccessListResponseModel]>.executeGetRequest(fromUrl: apiUrl, parameters: EmptyModel(), headerFields: headerFields) {[weak self] response in
            guard let `self` = self else { return }
            switch response {
            case .success(let response):
                 Utilities.securePrint(response)
                setupProfilesList(profileList: response)
                completion()
            case .failure(let error):
                Utilities.securePrint(error)
                setupProfilesList(profileList: nil)
                completion()
                //self.resultReceived.value = false
             //   self.alertModel.value.setValues(title: "Error", message: error.description ?? ApiKey.internetErrorMessage, isShown: true)
            }
        }
    }
    
    func getSwitchedPatientDetails(userId: String, onCompletion: @escaping() -> Void) {
        let tempURL = "\(Singleton.shared.getBaseUrl(portNumber: nil))\(PatientApiEnpoints.getPatientDetails)"
        let apiUrl = String(format: tempURL, userId) // grantorID
        let headerFields = ["Authorization": Singleton.shared.getBearerAccessToken()]
        self.setLoader(apiExecuted: false)
        ApiClient<EmptyModel, PatientDetailsResponseModel>.executeGetRequest(fromUrl: apiUrl, parameters: EmptyModel(), headerFields: headerFields) { [weak self] result in
            guard let `self` = self else { return }
            self.setLoader(apiExecuted: true)
            switch result {
            case .success(let response):
                Utilities.securePrint(response.id ?? "")
                Singleton.shared.setSelectedProfile(patientDetails: response)
                self.patientDataReceived.value = true
                NotificationCenter.default.post(name: NSNotification.Name("updatePatientData"), object: nil)
                onCompletion()
                isLoaderShown.value = false
            case .failure(let error):
                Utilities.securePrint(error)
                onCompletion()
                self.patientDataReceived.value = false
                self.alertModel.value.setValues(title: "Error", message: error.description ?? ApiKey.internetErrorMessage, isShown: true)
            }
        }
    }
    func getLocationBasedOnZipCode(zipCode: String = "10001", onCompletion: @escaping(Bool, ZipCodePlacemark?) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = zipCode
        let usaCenter = CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795)
        let usaSpan = MKCoordinateSpan(latitudeDelta: 49.3457868 - 24.396308, longitudeDelta: 125.000000 - 66.934570)
        let usaRegion = MKCoordinateRegion(center: usaCenter, span: usaSpan)
        searchRequest.region = usaRegion
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                Utilities.securePrint(error?.localizedDescription ?? "This should be impossible")
                onCompletion(false, nil)
                return
            }
            Utilities.securePrint(response.mapItems.first?.placemark.title ?? "No Placemarks")
            var placemarkModel: ZipCodePlacemark?
            if let placemark = response.mapItems.first?.placemark {
                Utilities.securePrint(placemark.country ?? "UNKNOWN_COUNTRY")
                placemarkModel = ZipCodePlacemark(zipCode: zipCode, city: response.mapItems.first?.placemark.locality ?? "", state: response.mapItems.first?.placemark.administrativeArea ?? "")
            }
            
            onCompletion(true, placemarkModel)
            
        }
    }
    func registerDeviceToken() {
        guard let deviceToken = Singleton.shared.fcmRegistrationToken else { return }
        guard let patient = Singleton.shared.patientDetails else { return }
        let patientName = patient.name?.first
        let apiUrl = "\(Singleton.shared.getBaseUrl(portNumber: nil))\(PatientApiEnpoints.registerDeviceTokenUrl)"
        
        let bodyParams = RegisterDeviceTokenRequestModel(subscriberId: patient.id ?? "", firstName: patientName?.given?.first ?? "", lastName: patientName?.family ?? "", phone: patient.getValueFromTelecom(field: ProfileTelecomTypes.phone) ?? "", email: patient.getValueFromTelecom(field: ProfileTelecomTypes.email) ?? "", deviceToken: deviceToken, locale: "en_US")
        
        let headerFields = ["Authorization": Singleton.shared.getBearerAccessToken()]
        
        ApiClient<RegisterDeviceTokenRequestModel, EmptyResponseModel>.executePostRequest(fromUrl: apiUrl, bodyParameters: bodyParams, requestParameters: EmptyModel(), headerFields: headerFields) { result in
            switch result {
            case .success(let response):
                Utilities.securePrint(response.success)
            case .failure(let error):
                Utilities.securePrint(error)
            }
        }
    }
    func deleteDeviceToken() {
        guard let deviceToken = Singleton.shared.fcmRegistrationToken else { return }
        guard let patient = Singleton.shared.patientDetails else { return }
        let patientName = patient.name?.first
        let tempUrl = "\(Singleton.shared.getBaseUrl(portNumber: nil))\(PatientApiEnpoints.deleteDeviceTokenUrl)"
        let apiUrl = String(format: tempUrl, patient.id ?? "", deviceToken)
        
        let headerFields = ["Authorization": Singleton.shared.getBearerAccessToken()]
        
        ApiClient<EmptyModel, EmptyResponseModel>.executeDeleteRequest(fromUrl: apiUrl, parameters: EmptyModel(), headerFields: headerFields, shouldUpdateUnauthorizedFlag: false) { result in
            switch result {
            case .success(let response):
                Utilities.securePrint(response.success)
            case .failure(let error):
                Utilities.securePrint(error)
            }
        }
    }
    func updateIngestionParams(ingestionStatus: String, recordFound: String = "") {
        guard let patient = Singleton.shared.patientDetails else { return }
//        Singleton.shared.setUserDataLoading(isLoading: false)
//        Singleton.shared.setIngestionStatus(status: ingestionStatus)
//        Singleton.shared.setIngestionRecordFound(status: recordFound)
        Singleton.shared.updateIngestionParams(isLoading: false, ingestionStatus: ingestionStatus, recordFound: recordFound)
    }
    func getPatientHealthContent(code: String, codeSystem: String, onCompletion: @escaping(Bool, [HealthContentResponseModel]?) -> Void) {
        let apiUrl = "\(Singleton.shared.getBaseUrl(portNumber: nil))\(PatientApiEnpoints.getHealthContentWithCode)"
        
        let requestParams = GetHealthContentRequestModel(codeSystem: codeSystem, code: code)
        let headerFields = ["Authorization": Singleton.shared.getBearerAccessToken()]
        
        ApiClient<GetHealthContentRequestModel, [HealthContentResponseModel]>.executeGetRequest(fromUrl: apiUrl, parameters: requestParams, headerFields: headerFields) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                Utilities.securePrint(response.first?.title ?? "")
                onCompletion(true, response)
            case .failure(let error):
                Utilities.securePrint(error)
                onCompletion(false, nil)
//                self.alertModel.value.setValues(title: "Error", message: error.description ?? ApiKey.internetErrorMessage, isShown: true)
            }
        }
    }
     */
}

struct ZipCodePlacemark {
    let zipCode: String
    let city: String
    let state: String
}
