//
//  DashboardViewController.h
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 6/3/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface DashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    UIActivityIndicatorView *spinner;

    UILabel *setDefaultL;
    
    NSMutableArray *countArray;
}

@property IBOutlet UITableView *getVideoListTV;

@end

NS_ASSUME_NONNULL_END
