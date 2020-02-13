#import "AppleSigninModule.h"
#import <React/RCTUtils.h>

@implementation AppleSigninModule

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    if (@available(iOS 13.0, *)) {
        NSDictionary *scopes = @{ @"FULL_NAME": ASAuthorizationScopeFullName,
                                  @"EMAIL": ASAuthorizationScopeEmail };
        NSDictionary *operations = @{ @"LOGIN": ASAuthorizationOperationLogin,
                                      @"LOGOUT": ASAuthorizationOperationLogout,
                                      @"REFRESH": ASAuthorizationOperationRefresh,
                                      @"IMPLICIT": ASAuthorizationOperationImplicit, };
        NSDictionary *credentialStates = @{ @"AUTHORIZED": @(ASAuthorizationAppleIDProviderCredentialAuthorized),
                                            @"REVOKED": @(ASAuthorizationAppleIDProviderCredentialRevoked),
                                            @"NOT_FOUND": @(ASAuthorizationAppleIDProviderCredentialNotFound) };
        NSDictionary *userDetectionStatuses = @{@"LIKELY_REAL": @(ASUserDetectionStatusLikelyReal),
                                                @"UNKNOW": @(ASUserDetectionStatusUnknown),
                                                @"UNSUPPORTED": @(ASUserDetectionStatusUnknown) };
        
        return @{ @"Scope": scopes,
                  @"Operation": operations,
                  @"CredentialState": credentialStates,
                  @"UserDetectionStatus": userDetectionStatuses,
        };
    } else {
        // Fallback on earlier versions
        return @{};
    }
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

RCT_EXPORT_METHOD(requestAsync: (NSDictionary *)options
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject) {
    if (@available(iOS 13.0, *)) {
        _promiseResolve = resolve;
        _promiseReject = reject;
        
        ASAuthorizationAppleIDProvider *appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *request = [appleIdProvider createRequest];
        request.requestedScopes = options[@"requestedScopes"];
        if (options[@"requestedOperation"]) {
            request.requestedOperation = options[@"requestedOperation"];
        }
        
        ASAuthorizationController *authController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        authController.presentationContextProvider = self;
        authController.delegate = self;
        [authController performRequests];
    }
}

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return RCTKeyWindow();
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDCredential *credential = authorization.credential;
    
    NSDictionary * user = @{ @"fullName": RCTNullIfNil(credential.fullName),
                             @"email": RCTNullIfNil(credential.email),
                             @"user": credential.user,
                             @"authorizationScopes": credential.authorizedScopes,
                             @"realUserStatus": @(credential.realUserStatus),
                             @"state": RCTNullIfNil(credential.state),
                             @"authorizationCode": RCTNullIfNil(credential.authorizationCode),
                             @"identifyToken": RCTNullIfNil([NSString stringWithUTF8String:[credential.identityToken bytes]]) };
    _promiseResolve(user);
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    _promiseReject(@"authorization", error.description, error);
    
}
@end
