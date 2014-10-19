//
//  MoviesViewController.h
//  Rotten Tomatoes
//
//  Created by Wes Chao on 10/13/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;
@property (weak, nonatomic) IBOutlet UIButton *networkErrorOKButton;
@property (weak, nonatomic) IBOutlet UITabBarItem *topDVDItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *boxOfficeItem;
@property (weak, nonatomic) IBOutlet UITabBar *mainTabBar;

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end
