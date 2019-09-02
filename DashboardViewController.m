//
//  DashboardViewController.m
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 6/3/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import "DashboardViewController.h"
#import "UploadViewController.h"
#import "DetailVideoViewController.h"
#import "ChooseNavigationController.h"
#import "UIViewController+LGSideMenuController.h"
#import "NavigationController.h"
#import "ProfileViewController.h"
#import "CustomCell.h"

@interface DashboardViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, strong) NSMutableDictionary *getDictValues;

@property (nonatomic, strong) NSMutableArray *getJsonInArr;
@property (nonatomic, strong) NSMutableArray *getFinalArr;
@property (nonatomic, strong) NSMutableArray *getVideosJsonInArr;
@property (nonatomic, strong) NSMutableArray *getVideosIDInArr;

@end

@implementation DashboardViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"VIDEOS";
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasLaunchedOnce"];
        
        [[UINavigationBar appearance] setTranslucent:YES];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:244.0/255.0 blue:86.0/255.0 alpha:1.0]];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        //        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageRoot"]];
        //        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        //        self.imageView.clipsToBounds = YES;
        //        [self.view addSubview:self.imageView];
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor blackColor],
           NSFontAttributeName:[UIFont fontWithName:@"Trebuchet MS" size:36.0]}];
        
        UIImage* slideImg = [UIImage imageNamed:@"accountIcon"];
        CGRect setFrameslideImg = CGRectMake(0, 0, slideImg.size.width, slideImg.size.height);
        UIButton *setSliderButtonImg = [[UIButton alloc] initWithFrame:setFrameslideImg];
        [setSliderButtonImg setBackgroundImage:slideImg forState:UIControlStateNormal];
        [setSliderButtonImg addTarget:self action:@selector(showLeftView)
                     forControlEvents:UIControlEventTouchUpInside];
        [setSliderButtonImg setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *setSliderBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:setSliderButtonImg];
        self.navigationItem.leftBarButtonItem=setSliderBarBtnItem;
        
        UIImage* uploadImg = [UIImage imageNamed:@"videoIcon"];
        CGRect setFrameUploadImg = CGRectMake(0, 0, uploadImg.size.width, uploadImg.size.height);
        UIButton *setUploadButtonImg = [[UIButton alloc] initWithFrame:setFrameUploadImg];
        [setUploadButtonImg setBackgroundImage:uploadImg forState:UIControlStateNormal];
        [setUploadButtonImg addTarget:self action:@selector(showRightView)
                     forControlEvents:UIControlEventTouchUpInside];
        [setUploadButtonImg setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *setUploadBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:setUploadButtonImg];
        self.navigationItem.rightBarButtonItem=setUploadBarBtnItem;
        
        _getDictValues = [[NSMutableDictionary alloc] init];
        _getFinalArr = [NSMutableArray array];
        _getVideosJsonInArr = [NSMutableArray array];
        _getVideosIDInArr = [NSMutableArray array];
        
        [_getVideoListTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        //init lable Text
        int WidthOfLabel = 320;
        int someHeight = 50;
        
        setDefaultL = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-(WidthOfLabel/2)-10, self.view.center.y-100, WidthOfLabel, someHeight)];
        setDefaultL.backgroundColor = [UIColor clearColor];
        setDefaultL.hidden = NO;
        setDefaultL.textAlignment = NSTextAlignmentCenter;
        [setDefaultL setFont: [setDefaultL.font fontWithSize: 20.0f]];
        setDefaultL.textColor = [UIColor whiteColor];
        setDefaultL.numberOfLines = 1;
        setDefaultL.lineBreakMode = UILineBreakModeWordWrap;
        setDefaultL.text = @"There is no data to show.";
        
        _getVideoListTV.separatorColor = [UIColor clearColor];
        _getVideoListTV.backgroundColor = [UIColor clearColor];
        [self.view addSubview:setDefaultL];
        
        countArray = [[NSMutableArray alloc] init];
        
//        [self getChannelList];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]){
        
//        UIWindow *window = UIApplication.sharedApplication.delegate.window;
//
////        [self dismissViewControllerAnimated:YES completion:^{
//            [window.rootViewController dismissViewControllerAnimated:YES completion:^{
//
//            }];
////        }];
        
            [[[[[self parentViewController] parentViewController] parentViewController] parentViewController] dismissViewControllerAnimated:YES completion:^{
                
            }];
        
            [self dismissViewControllerAnimated:NO completion:^{
                [self dismissViewControllerAnimated:NO completion:^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }]; // Third
                }]; // Second
            }]; // First
        
        

        
//        UIViewController *vc = self.presentingViewController;
//        while (vc.presentingViewController) {
//            vc = vc.presentingViewController;
//        }
//
//        [vc dismissViewControllerAnimated:YES completion:NULL];

        
//        if ([self.presentedViewController isBeingDismissed])
//        {
////            [self dismissModalViewControllerAnimated:YES completion:nil];
//
//            [self dismissViewControllerAnimated:YES completion:^{
//
//            }];
//        }
    }else{
        NSMutableArray *unique = [NSMutableArray array];
        
        for (id obj in _getFinalArr) {
            if (![unique containsObject:obj]) {
                [unique addObject:obj];
            }
            else{
                [_getFinalArr removeAllObjects];
//                [self getChannelList];
            }
            NSLog(@"_get: %@",_getFinalArr);
        }
    }
}

- (void) getChannelList{
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.frame = CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 40, 40);
    
    spinner.center = self.view.center;
    
    [self.view addSubview:spinner];
    
    [spinner startAnimating];
    
    // Set up your URL
    NSString *youtubeApi = //@"https://www.googleapis.com/youtube/v3/search?key=AIzaSyByo4xmIGenNhu7xRZih1JJKZI6Hh04lh0&channelId=UC2piC7eXPns9YXoto2R5JnQ&part=id&order=date&maxResults=20";
    
    @"https://www.googleapis.com/youtube/v3/search?key=AIzaSyB-qRkzNjhVuZKj7e-ljb4EF1624BDj5uY&channelId=UC2piC7eXPns9YXoto2R5JnQ&part=id&order=date&maxResults=20";
    
    //@"https://www.googleapis.com/youtube/v3/channels?part=contentDetails%2Csnippet%2Cstatistics%2Cid&forUsername=Arena&key=AIzaSyByo4xmIGenNhu7xRZih1JJKZI6Hh04lh0";
    
    NSURL *url = [[NSURL alloc] initWithString:youtubeApi];
    
    // Create your request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Send the request asynchronously
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        
        // Callback, parse the data and check for errors
        if (data && !connectionError) {
            NSError *jsonError;
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            if ([jsonResult valueForKey:@"error"]) {
                
                NSLog(@"Error is: %@", [[jsonResult valueForKey:@"error"] valueForKey:@"message"]);
            }else{
                if (!jsonError) {
                    _getJsonInArr  = [jsonResult valueForKey:@"items"];
                    
                    for (int i=0;i< _getJsonInArr.count;i++) {
                        
                        if (_getJsonInArr[i][@"id"][@"videoId"]) {
                            NSLog(@"There's an object set for key @\"videoId\"!");
                            
                            [_getVideosIDInArr addObject:_getJsonInArr[i][@"id"][@"videoId"]];
                        }else {
                            NSLog(@"No object set for key @\"videoId\"");
                        }
                    }
                    
                    [self getVideoData];
                }else{
                    NSLog(@"SOME ERROR");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [spinner stopAnimating];
                        _getVideoListTV.separatorColor = [UIColor clearColor];
                        setDefaultL.hidden = NO;
                   });
                }
            }
        }else{
            NSLog(@"SOME ERROR");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [spinner stopAnimating];
                _getVideoListTV.separatorColor = [UIColor clearColor];
                setDefaultL.hidden = NO;
            });
        }
    }] resume];
}

- (void) getVideoData{
    
    NSLog(@"_getVideosIDInArr: %@", _getVideosIDInArr);
    
    NSString *getStringFromArr = [NSString stringWithFormat:@"%@",_getVideosIDInArr];
    
    NSString *stringWithoutCharacters = [getStringFromArr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    NSString *stringWithoutCharacters2 = [stringWithoutCharacters stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSString *stringWithoutInvertedCommas = [stringWithoutCharacters2 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSString *newString = [[stringWithoutInvertedCommas componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    
    NSString* noSpaces = [[newString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    NSString *getVideosDataAPI = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?part=statistics,snippet&id=%@&key=AIzaSyByo4xmIGenNhu7xRZih1JJKZI6Hh04lh0", noSpaces];
    
    NSURL *videoURL = [[NSURL alloc] initWithString:getVideosDataAPI];
    
    // Create your request
    NSURLRequest *videoRequest = [NSURLRequest requestWithURL:videoURL];
    
    // Send the request asynchronously
    [[[NSURLSession sharedSession] dataTaskWithRequest:videoRequest completionHandler:^(NSData *vData, NSURLResponse *vResponse, NSError *vConnectionError) {
        
        // Callback, parse the data and check for errors
        if (vData && !vConnectionError) {
            NSError *vJsonError;
            NSDictionary *vJsonResult = [NSJSONSerialization JSONObjectWithData:vData options:NSJSONReadingMutableContainers error:&vJsonError];
            
            if (!vJsonError) {
                NSLog(@"Response from Video YouTube API: %@", vJsonResult);
                
                _getVideosJsonInArr  = [vJsonResult valueForKey:@"items"];
                _getDictValues  = [[vJsonResult valueForKey:@"items"] valueForKey:@"snippet"];
                
                NSLog(@"_getVideosJsonInArr: %@", _getVideosJsonInArr);
                NSLog(@"_getDictValues: %@", _getDictValues);
                
                for (int i=0;i< _getVideosJsonInArr.count;i++) {
                    
                    _getDictValues = _getVideosJsonInArr[i][@"snippet"];
                    
                    NSMutableDictionary *videoDict = [NSMutableDictionary new];
                    
                    videoDict[@"title"] = _getDictValues[@"title"];
                    videoDict[@"channelTitle"] = _getDictValues[@"channelTitle"];
                    videoDict[@"thumbnail"] = _getDictValues[@"thumbnails"][@"medium"][@"url"];
                    videoDict[@"videoID"] = [[_getVideosJsonInArr valueForKey:@"id"] objectAtIndex:i];
                    videoDict[@"videoLikeCount"] = [[[_getVideosJsonInArr valueForKey:@"statistics"] valueForKey:@"likeCount"] objectAtIndex:i];
                    videoDict[@"videoViewCount"] = [[[_getVideosJsonInArr valueForKey:@"statistics"] valueForKey:@"viewCount"] objectAtIndex:i];
                    
                    [_getFinalArr addObject:videoDict];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [spinner stopAnimating];
                    setDefaultL.hidden = YES;
                    
                    [self setAllElementofArrayToZero];

                    [_getVideoListTV reloadData];
                    // Your UI update code here
                });
            }
        }
    }] resume];
}

#pragma mark -

- (void)showLeftView {
    //    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
    
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:profileVC];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
//    UIViewController *viewController = [UIViewController new];
//    viewController.view.backgroundColor = [UIColor whiteColor];
//    viewController.title = @"MY ACCOUNT";
//
//    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)showRightView {
    //    UIViewController *viewController = [UIViewController new];
    //    viewController.view.backgroundColor = [UIColor whiteColor];
    //    viewController.title = @"UPLOAD VIDEO";
    //
    //    UploadViewController *uploadVC = [[UploadViewController alloc] initWithNibName:@"UploadViewController" bundle:nil];
    //    [self presentViewController:uploadVC animated:YES completion:nil];
    
    
    
    
//        UploadViewController *uploadVC;
//        uploadVC = [UploadViewController new];
//
//        NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:uploadVC];
//
//        UIWindow *window = UIApplication.sharedApplication.delegate.window;
//        window.rootViewController = navigationController;
//
//        [self presentViewController:window.rootViewController animated:YES completion:nil];
    
    
    UploadViewController *uploadVC = [[UploadViewController alloc] init];
//    [uploadVC captureVideo:self];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:uploadVC];
    
    //        UIWindow *window = UIApplication.sharedApplication.delegate.window;
    //        window.rootViewController = navigationController;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _getFinalArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell;
    static NSString *identifier = @"CustomCell";
    cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setTitle:@"click count" forState:UIControlStateNormal];
        //set the position of the button
        [button setFrame:CGRectMake(5, 195, 400, 60)];
        [button addTarget:self action:@selector(increaseItemCount:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor= [UIColor clearColor];
        [cell.contentView addSubview:button];
        
        cell.cellBackgroundImg.layer.cornerRadius = 10.0;
        cell.cellBackgroundImg.clipsToBounds = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UILabel *displayCount = (UILabel *)[cell viewWithTag:1];
    displayCount.text = [NSString stringWithFormat:@"%@",[countArray objectAtIndex:indexPath.row]];
    
    cell.getVideoTitle.text = [[_getFinalArr valueForKeyPath:@"title"] objectAtIndex:indexPath.row];
    
    cell.getVideoTotalLikesL.text = [NSString stringWithFormat:@"%@ Likes",[countArray objectAtIndex:indexPath.row]];
    
//    cell.getVideoTotalLikesL.text = [NSString stringWithFormat:@"%@ Likes",[[_getFinalArr valueForKeyPath:@"videoLikeCount"] objectAtIndex:indexPath.row]];
    
    cell.getVideoTotalViewsL.text = [[_getFinalArr valueForKeyPath:@"videoViewCount"] objectAtIndex:indexPath.row];
    
    NSString *str = [[_getFinalArr valueForKey:@"thumbnail"] objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:str]];
            cell.getVideoThumbnail.image = [UIImage imageWithData: imageData];
            
            // Create the path (with only the top-left corner rounded)
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.getVideoThumbnail.bounds
                                                           byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                                 cornerRadii:CGSizeMake(10.0, 10.0)];
            
            // Create the shape layer and set its path
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            //    maskLayer.frame = cell.getVideoThumbnail.bounds;
            maskLayer.path = maskPath.CGPath;
            // Set the newly created shapelayer as the mask for the image view's layer
            cell.getVideoThumbnail.layer.mask = maskLayer;
        });
    });
    
    return cell;
}

- (void)setAllElementofArrayToZero
{
    for(int i = 0;i < _getFinalArr.count ;i++)
    {
        [countArray addObject:[NSNumber numberWithInteger:0]];
    }
}

-(void)increaseItemCount:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.getVideoListTV indexPathForCell:cell];
    
    [countArray replaceObjectAtIndex:path.row withObject:[NSNumber numberWithInteger:[[countArray objectAtIndex:path.row] intValue]+1 ]];
    
    [self.getVideoListTV beginUpdates];
    [self.getVideoListTV reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    [self.getVideoListTV endUpdates];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"videoID %@", [[_getFinalArr valueForKey:@"videoID"] objectAtIndex:indexPath.row]);
    
    DetailVideoViewController *detailVC = [[DetailVideoViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    detailVC.getVideoID = [NSString stringWithFormat:@"%@", [[_getFinalArr valueForKey:@"videoID"] objectAtIndex:indexPath.row]];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
