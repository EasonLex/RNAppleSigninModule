#import <React/RCTViewManager.h>
#import <React/RCTUtils.h>
#import "RNCSignInWithAppleButton.h"
@import AuthenticationServices;

@interface RNCSignInWithAppleBlackButtonManager : RCTViewManager
@end

@implementation RNCSignInWithAppleBlackButtonManager

RCT_EXPORT_MODULE(RNCSignInWithAppleBlackButtonManager)

- (UIView *)view
{
  RNCSignInWithAppleButton *rnAppleSigninButton = [[RNCSignInWithAppleButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
    
  return rnAppleSigninButton;
}

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(nativeStyle, NSDictionary, RNCSignInWithAppleButton) {
    NSDictionary *nativeStyle = json ? [RCTConvert NSDictionary:json]:@{};
    NSNumber *mynumber = [nativeStyle valueForKey:@"cornerRadius"];

    view.cornerRadius = [mynumber doubleValue];
}
@end
