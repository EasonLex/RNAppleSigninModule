#import <React/RCTViewManager.h>
#import <React/RCTUtils.h>
#import "RNCSignInWithAppleButton.h"
@import AuthenticationServices;

@interface RNCSignInWithAppleButtonManager : RCTViewManager
@end

@implementation RNCSignInWithAppleButtonManager

RCT_EXPORT_MODULE(RNCSignInWithAppleButtonManager)

- (UIView *)view
{
  RNCSignInWithAppleButton *rnAppleSigninButton = [[RNCSignInWithAppleButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
    
  return rnAppleSigninButton;
}

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(nativeStyle, NSDictionary, RNCSignInWithAppleButton) {
    NSDictionary *nativeStyle = json ? [RCTConvert NSDictionary:json]:@{};
    NSNumber *mynumber = [nativeStyle valueForKey:@"cornerRadius"];

    view.cornerRadius = [mynumber doubleValue];
}
@end
