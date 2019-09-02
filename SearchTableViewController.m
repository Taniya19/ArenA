//
//  SearchTableViewController.m
//  LGSideMenuControllerDemo
//
//  Created by Vivek Tyagi on 5/27/19.
//  Copyright © 2019 Grigory Lutkov. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()

@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation SearchTableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = @"CATEGORIES";
        
        self.view.backgroundColor = [UIColor whiteColor];
        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                                                                 style:UIBarButtonItemStylePlain
//                                                                                target:self
//                                                                                action:@selector(showChooseController)];
        
        self.titlesArray = @[@"Baseball",
                             @"Basketball",
                             @"Beach Volleyball",
                             @"Bowling",
                             @"Body Building",
                             @"Cross Country",
                             @"Equestrian",
                             @"Fencing",
                             @"Field Hockey",
                             @"Football",
                             @"Golf",
                             @"Gymnastics",
                             @"Ice Hockey",
                             @"Lacrosse",
                             @"Rifle",
                             @"Rowing",
                             @"Rugby",
                             @"Robotics",
                             @"Skiing",
                             @"Soccer",
                             @"Softball",
                             @"Swimming and diving",
                             @"Tennis",
                             @"Track and field (indoor)",
                             @"Track and field (outdoor)",
                             @"Triathlon",
                             @"Volleyball",
                             @"Water polo",
                             @"Wrestling",
                             @"Skate boarding",
                             @"Surfing",
                             @"Rock Climbing", @"Sailing", @"Video Gaming"];
        
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
        self.titlesArray = [self.titlesArray sortedArrayUsingDescriptors:@[sd]];
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
//        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArenaLaunch7"]]; //Arena_backgroundEight //Arena_launch
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView.clipsToBounds = YES;
//
//        [self.view addSubview:self.imageView];
        
        
//        self.numberOfCells = 10;
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    self.imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

//#pragma mark -
//
//- (void)showChooseController {
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.numberOfCells;
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:17.0]; //[UIFont systemFontOfSize:16.0];
    cell.textLabel.text = self.titlesArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        self.numberOfCells--;
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}

@end
