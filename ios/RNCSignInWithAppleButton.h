#import <React/RCTComponent.h>
@import AuthenticationServices;

@interface RNCSignInWithAppleButton : ASAuthorizationAppleIDButton

@property (nonatomic, copy) RCTBubblingEventBlock onPress;
@property (nonatomic, assign) CGFloat cornerRadius;
@end
