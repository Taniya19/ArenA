//
//  ViewController.h
//  LGSideMenuControllerDemo
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
{
    UIActivityIndicatorView *spinner;
    
    UILabel *setDefaultL;
    
    NSMutableArray *countArray;
}

@property IBOutlet UITableView *getVideoListTV;

@end
