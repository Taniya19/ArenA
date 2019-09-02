//
//  ViewController.m
//  LGSideMenuControllerDemo
//

#import "ViewController.h"
#import "ChooseNavigationController.h"
#import "UIViewController+LGSideMenuController.h"
#import "UploadViewController.h"
#import "DetailVideoViewController.h"
#import "ChooseNavigationController.h"
#import "UIViewController+LGSideMenuController.h"
#import "NavigationController.h"
#import "CustomCell.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *BGImageView;
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, strong) NSMutableArray *getJsonInArr;
@property (nonatomic, strong) NSMutableArray *getFinalArr;
@property (nonatomic, strong) NSMutableArray *getVideosJsonInArr;
@property (nonatomic, strong) NSMutableArray *getVideosIDInArr;
@property (nonatomic, strong) NSMutableDictionary *getDictValues;

@end

@implementation ViewController


- (id)init {
    self = [super init];
    if (self) {
        self.title = @"PUBLIC VIDEOS";
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasLaunchedOnce"];
        
        [[UINavigationBar appearance] setTranslucent:YES];

        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:244.0/255.0 blue:86.0/255.0 alpha:1.0]];

        self.view.backgroundColor = [UIColor whiteColor];

        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArenaLaunch5"]];//Arena+backgroundOne1 //Arena_backgroundTwo_2
        self.imageView.contentMode = UIViewContentModeScaleAspectFill; //UIViewContentModeLeft //UIViewContentModeScaleAspectFill
        self.imageView.clipsToBounds = YES;
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor blackColor],
           NSFontAttributeName:[UIFont fontWithName:@"Trebuchet MS" size:36.0]}];
        
        UIImage* image3 = [UIImage imageNamed:@"hamburgerIcon"];
        CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
        UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
        [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
        [someButton addTarget:self action:@selector(showLeftView)
             forControlEvents:UIControlEventTouchUpInside];
        [someButton setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
        self.navigationItem.leftBarButtonItem=mailbutton;
        
        _getDictValues = [[NSMutableDictionary alloc] init];
        _getFinalArr = [NSMutableArray array];
        _getVideosJsonInArr = [NSMutableArray array];
        _getVideosIDInArr = [NSMutableArray array];
        
        //init lable Text
        int WidthOfLabel = 320;
        int someHeight = 50;
        
        setDefaultL = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-(WidthOfLabel/2), self.view.center.y, WidthOfLabel, someHeight)];
        setDefaultL.backgroundColor = [UIColor clearColor];
        setDefaultL.hidden = NO;
        setDefaultL.textAlignment = NSTextAlignmentCenter;
        [setDefaultL setFont: [setDefaultL.font fontWithSize: 20.0f]];
        setDefaultL.textColor = [UIColor whiteColor];
        setDefaultL.numberOfLines = 1;
        setDefaultL.lineBreakMode = UILineBreakModeWordWrap;
        setDefaultL.text = @"There is no data to show.";
        
        // init table view
        _getVideoListTV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        // must set delegate & dataSource, otherwise the the table will be empty and not responsive
        _getVideoListTV.delegate = self;
        _getVideoListTV.dataSource = self;
        
        _getVideoListTV.backgroundColor = [UIColor clearColor];
        _getVideoListTV.separatorColor = [UIColor clearColor];
        [_getVideoListTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.BGImageView = [[UIImageView alloc] init];
        [self.BGImageView setBackgroundColor:[UIColor blackColor]];
        [self.BGImageView setAlpha:0.40];
        self.BGImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.BGImageView.clipsToBounds = YES;
        
        [self.view addSubview:self.imageView];
        [self.view addSubview:self.BGImageView];
        [self.view addSubview:_getVideoListTV];
        [self.view addSubview:setDefaultL];
        
        countArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    self.BGImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

#pragma mark -

- (void)showLeftView {

     [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (!_getFinalArr || !_getFinalArr.count){
//        [self getChannelList];
    }else if (_getFinalArr == nil){
        NSLog(@"SOME ERROR");

        [spinner stopAnimating];

        _getVideoListTV.separatorColor = [UIColor clearColor];

        setDefaultL.hidden = NO;
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
    NSString *youtubeApi =
    //@"";
    //AIzaSyB-qRkzNjhVuZKj7e-ljb4EF1624BDj5uY
    //AIzaSyByo4xmIGenNhu7xRZih1JJKZI6Hh04lh0 // old
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
                    
                    _getVideoListTV.separatorColor = [UIColor clearColor];
                    setDefaultL.hidden = YES;
                    
                    [self setAllElementofArrayToZero];

                    [_getVideoListTV reloadData];
                    // Your UI update code here
                });
            }else{
                
                NSLog(@"SOME ERROR");

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [spinner stopAnimating];
                    _getVideoListTV.separatorColor = [UIColor clearColor];
                    setDefaultL.hidden = NO;
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [spinner stopAnimating];
                _getVideoListTV.separatorColor = [UIColor clearColor];
                setDefaultL.hidden = NO;
            });
        }
    }] resume];
}

#pragma mark -

- (void)showRightView {
    UploadViewController *uploadVC = [[UploadViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:uploadVC];

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
        
//        [cell.getLikeCounterIncrease addTarget:self action:@selector(increaseItemCount:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    UILabel *displayCount = (UILabel *)[cell viewWithTag:1];
    displayCount.text = [NSString stringWithFormat:@"%@",[countArray objectAtIndex:indexPath.row]];
    //[NSString stringWithFormat:@"%i",[[countArray objectAtIndex:indexPath.row] intValue]];
    
    cell.getVideoTitle.text = [[_getFinalArr valueForKeyPath:@"title"] objectAtIndex:indexPath.row];
    
    cell.getVideoTotalLikesL.text = [NSString stringWithFormat:@"%@ Likes",[countArray objectAtIndex:indexPath.row]];
    
//    cell.getVideoTotalLikesL.text = [NSString stringWithFormat:@"%@",[[_getFinalArr valueForKeyPath:@"videoLikeCount"] objectAtIndex:indexPath.row]];
    
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
    return 265.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"videoID %@", [[_getFinalArr valueForKey:@"videoID"] objectAtIndex:indexPath.row]);
    
    DetailVideoViewController *detailVC = [[DetailVideoViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    detailVC.getVideoID = [NSString stringWithFormat:@"%@", [[_getFinalArr valueForKey:@"videoID"] objectAtIndex:indexPath.row]];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}



@end
