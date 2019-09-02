//
//  ChooseNavigationController.m
//  LGSideMenuControllerDemo
//

#import "ChooseNavigationController.h"
#import "TableViewController.h"
#import "ViewController.h"

@implementation ChooseNavigationController

- (instancetype)init{
    TableViewController *viewController = [TableViewController new];
    
    self = [super initWithRootViewController:viewController];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

//    [[UINavigationBar appearance] setTranslucent:NO];

//    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];//[UIColor colorWithRed:66.0/255.0 green:244.0/255.0 blue:86.0/255.0 alpha:1.0]
    
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    
//    self.navigationBar.tintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
//    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"2pxWidthLineImage"]];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;//UIStatusBarStyleLightContent
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

@end
