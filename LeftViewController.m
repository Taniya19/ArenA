//
//  LeftViewController.m
//  LGSideMenuControllerDemo
//

#import "LeftViewController.h"
#import "LeftViewCell.h"
#import "MainViewController.h"
#import "UIViewController+LGSideMenuController.h"
#import "ViewController.h"
#import "MyAccountViewController.h"
#import "SearchTableViewController.h"

#import "DashboardViewController.h"
#import "MainViewController.h"

@interface LeftViewController ()

@property (strong, nonatomic) NSArray *titlesArray;

@end

@implementation LeftViewController

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.titlesArray = @[@"",
                             @"",
                             @"",
                             @"",
                             @"My Account",
                             @"Search",
                             @""];

        self.view.backgroundColor = [UIColor clearColor];

        [self.tableView registerClass:[LeftViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.contentInset = UIEdgeInsetsMake(44.0, 0.0, 44.0, 0.0);
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.separatorView.hidden = (indexPath.row <= 3 || indexPath.row == self.titlesArray.count-1);
    cell.userInteractionEnabled = (indexPath.row != 1 && indexPath.row != 3);

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row == 1 || indexPath.row == 3) ? 22.0 : 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewController *mainViewController = (MainViewController *)self.sideMenuController;

    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 6) {
//        if ([mainViewController isLeftViewAlwaysVisibleForCurrentOrientation]) {
//            [mainViewController showRightViewAnimated:YES completionHandler:nil];
//        }
//        else {
//            [mainViewController hideLeftViewAnimated:YES completionHandler:^(void) {
//                [mainViewController showRightViewAnimated:YES completionHandler:nil];
//            }];
//        }
    }
    else if (indexPath.row == 4) {
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"])
        {
//            [self displayMyAccountScreen];

            MyAccountViewController *viewController = [MyAccountViewController new];
            viewController.view.backgroundColor = [UIColor whiteColor];
            UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
            [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
            [navigationController pushViewController:viewController animated:YES];
            
//            [navigationController presentViewController:viewController animated:YES completion:nil];

            
        } else {
//            [self displayDashboardScreen];

            /* Temoporary FIX */
            
//            MyAccountViewController *viewController = [MyAccountViewController new];
//            viewController.view.backgroundColor = [UIColor whiteColor];
//            UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
//            [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
//            [navigationController pushViewController:viewController animated:YES];
            
            UIViewController *viewController;
            viewController = [DashboardViewController new];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            MainViewController *mainViewController = [MainViewController new];
            mainViewController.rootViewController = navigationController;
            
            UIWindow *window = UIApplication.sharedApplication.delegate.window;
            window.rootViewController = mainViewController;
            
            [UIView transitionWithView:window
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
        }
    }else if (indexPath.row == 5){
        SearchTableViewController *viewController = [SearchTableViewController new];
        viewController.view.backgroundColor = [UIColor whiteColor];
        
        UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
        
        [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
        
        [navigationController pushViewController:viewController animated:YES];
    }
    else {
        UIViewController *viewController = [UIViewController new];
        viewController.view.backgroundColor = [UIColor whiteColor];
        viewController.title = self.titlesArray[indexPath.row];

        UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
        
        [mainViewController hideLeftViewAnimated:YES completionHandler:nil];

        [navigationController pushViewController:viewController animated:YES];
    }
}

@end
