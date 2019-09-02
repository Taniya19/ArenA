//
//  CustomCell.h
//  CustomCell
//
//  Created by Shenghua Lu on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImgV;
}

@property (retain, nonatomic) IBOutlet UILabel *getVideoTitle;
@property (retain, nonatomic) IBOutlet UIImageView *getVideoThumbnail;
@property (retain, nonatomic) IBOutlet UILabel *getVideoTotalViewsL;
@property (retain, nonatomic) IBOutlet UILabel *getVideoTotalLikesL;
@property (nonatomic, retain) IBOutlet UIImageView *cellBackgroundImg;

@property (nonatomic, retain) IBOutlet UIButton *getLikeCounterIncrease;

@end
