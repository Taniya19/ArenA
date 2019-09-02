//
//  DetailVideoViewController.m
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 6/7/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import "DetailVideoViewController.h"

@interface DetailVideoViewController ()

@end

@implementation DetailVideoViewController


- (id)init {
    self = [super init];
    if (self) {
        self.title = @"VIDEOS";
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    
    UIImage* slideImg = [UIImage imageNamed:@"backIcon"];
    CGRect setFrameslideImg = CGRectMake(0, 0, slideImg.size.width, slideImg.size.height);
    UIButton *setSliderButtonImg = [[UIButton alloc] initWithFrame:setFrameslideImg];
    [setSliderButtonImg setBackgroundImage:slideImg forState:UIControlStateNormal];
    [setSliderButtonImg addTarget:self action:@selector(goToPrvsScreen)
                 forControlEvents:UIControlEventTouchUpInside];
    [setSliderButtonImg setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *setSliderBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:setSliderButtonImg];
    self.navigationItem.leftBarButtonItem=setSliderBarBtnItem;
    
    NSLog(@"_getVideoID: %@", _getVideoID);
    
    [self playVideoWithId:_getVideoID];
}

- (void)goToPrvsScreen {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)playVideoWithId:(NSString *)videoId {
    
    youTubeVideoHTML = @"<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>";
    
    loadYoutubeURLInWebV.allowsInlineMediaPlayback = YES;
    loadYoutubeURLInWebV.mediaPlaybackRequiresUserAction = NO;
    
    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, self.view.frame.size.width, self.view.frame.size.height, videoId];
    
    [loadYoutubeURLInWebV loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
