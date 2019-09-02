//
//  DetailVideoViewController.h
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 6/7/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailVideoViewController : UIViewController <UIWebViewDelegate>{
    NSString *youTubeVideoHTML;
    
    IBOutlet UIWebView *loadYoutubeURLInWebV;
}

@property (nonatomic, strong) NSString *getVideoID;

@end

NS_ASSUME_NONNULL_END
