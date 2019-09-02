//
//  NavigationController.m
//  LGSideMenuControllerDemo
//

#import "NavigationController.h"
#import "UIViewController+LGSideMenuController.h"

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UINavigationBar appearance] setTranslucent:YES];

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:244.0/255.0 blue:86.0/255.0 alpha:1.0]];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.sideMenuController.isRightViewVisible ? UIStatusBarAnimationSlide : UIStatusBarAnimationFade;
}

@end
