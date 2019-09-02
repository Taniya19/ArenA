//
//  CustomCell.m
//  CustomCell
//
//  Created by Shenghua Lu on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize getVideoTitle;
@synthesize getVideoThumbnail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    // border radius
    [backgroundImgV.layer setCornerRadius:30.0f];
    
    // border
    [backgroundImgV.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [backgroundImgV.layer setBorderWidth:1.5f];
    
    // drop shadow
    [backgroundImgV.layer setShadowColor:[UIColor blackColor].CGColor];
    [backgroundImgV.layer setShadowOpacity:0.8];
    [backgroundImgV.layer setShadowRadius:3.0];
    [backgroundImgV.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
