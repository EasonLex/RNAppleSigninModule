#import <React/RCTBridgeModule.h>

@import AuthenticationServices;

@interface AppleSigninModule : NSObject <RCTBridgeModule,
ASAuthorizationControllerDelegate,
ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) RCTPromiseResolveBlock promiseResolve;
@property (nonatomic, strong) RCTPromiseRejectBlock promiseReject;

@end
