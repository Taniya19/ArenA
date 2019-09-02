//
//  TableViewController.m
//  LGSideMenuControllerDemo
//

#import "TableViewController.h"
#import "MainViewController.h"
#import "NavigationController.h"
#import "ViewController.h"

@interface TableViewController ()

@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) UIButton *buttonBG;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation TableViewController

- (id)init {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (self.navigationController.navigationBar.hidden == NO)
    {
        // hide the Navigation Bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
//    self.navigationController.navigationBarHidden = YES;
//    
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //[UIColor colorWithRed:66.0 green:244.0 blue:86.0 alpha:1.0];
    
//    UIImage* image3 = [UIImage imageNamed:@"hamburgerIcon"];
//    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
//    [someButton setShowsTouchWhenHighlighted:YES];
//
//    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
//    self.navigationItem.leftBarButtonItem=mailbutton;
    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
//        self.title = @"PUBLIC VIDEOS";
        self.tableView.backgroundView.backgroundColor = [UIColor whiteColor];
        CGRect labelFrame;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                    case 1136:
                    printf("iPhone 5 or 5S or 5C");
                    labelFrame = CGRectMake(-15,self.view.frame.size.height/2-23,374,70); //CGRectMake(20,342,374,70)

                    break;
                    
                    case 1334:
                    printf("iPhone 6/6S/7/8");
                    labelFrame = CGRectMake(-15,self.view.frame.size.height/2-23,374,70); //CGRectMake(20,342,374,70)

                    break;
                    
                    case 1920 | 2208:
                    printf("iPhone 6+/6S+/7+/8+");
                    labelFrame = CGRectMake(-15,self.view.frame.size.height/2-23,374,70); //CGRectMake(20,342,374,70)

                    break;
                    
                    case 2436:
                    printf("iPhone X, XS");
                    labelFrame = CGRectMake(20,362,374,70);
                    break;
                    
                    case 2688:
                    printf("iPhone XS Max");
                    labelFrame = CGRectMake(20,362,374,70);

                    break;
                    
                    case 1792:
                    printf("iPhone XR");
                    labelFrame = CGRectMake(20,362,374,70);

                    break;
                    
                default:
                    printf("Unknown");
                    labelFrame = CGRectMake(-15,self.view.frame.size.height/2-23,374,70); //CGRectMake(20,342,374,70)

                    break;
            }
        }
        
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
        myLabel.backgroundColor = [UIColor clearColor];
        myLabel.textColor = [UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:57.0/255.0 alpha:1.0];
        myLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:60.0];
        myLabel.numberOfLines = 1;
        myLabel.text = @"ArenA";
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.shadowColor = [UIColor clearColor];
        myLabel.shadowOffset = CGSizeMake(1.0,1.0);
        
        [self.tableView setSeparatorColor:[UIColor clearColor]];
        self.titlesArray = @[@"Show dashboard screen"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arena_backgroundEight"]]; //Arena_backgroundEight //Arena_launch
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self.view addSubview:self.imageView];
        [self.view addSubview:myLabel];
    }
    
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                case 1136:
                printf("iPhone 5 or 5S or 5C");
                self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 0.0);

                break;
                
                case 1334:
                printf("iPhone 6/6S/7/8");
                self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 0.0);

                break;
                
                case 1920 | 2208:
                printf("iPhone 6+/6S+/7+/8+");
                self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 0.0);

                break;
                
                case 2436:
                printf("iPhone X, XS");
                self.imageView.frame = CGRectMake(0.0, -44.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 44.0);
                break;
                
                case 2688:
                printf("iPhone XS Max");
                self.imageView.frame = CGRectMake(0.0, -44.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 44.0);

                break;
                
                case 1792:
                printf("iPhone XR");
                self.imageView.frame = CGRectMake(0.0, -44.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 44.0);

                break;
                
            default:
                printf("Unknown");
                self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 0.0);

                break;
        }
    }
}

#pragma mark - ViewDidAppear Method

-(void) viewDidAppear:(BOOL)animated{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"] == YES) {
        [self showNextScreen];
    }else{
        NSLog(@"HasLaunchedOnce is NO");
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - UIViewPopup show

- (void)showNextScreen{
    UIViewController *viewController;
    viewController = [ViewController new];
    
    NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:viewController];
    
    MainViewController *mainViewController = [MainViewController new];
    mainViewController.rootViewController = navigationController;
    [mainViewController setupWithType:0];
    
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.rootViewController = mainViewController;
    
    [self presentViewController:window.rootViewController animated:NO completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:17.0]; //[UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor clearColor];
    cell.textLabel.text = self.titlesArray[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController;
    viewController = [ViewController new];
    
    NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:viewController];
    
    MainViewController *mainViewController = [MainViewController new];
    mainViewController.rootViewController = navigationController;
    [mainViewController setupWithType:0];
    
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.rootViewController = mainViewController;

    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;//UIStatusBarStyleLightContent
}

@end
