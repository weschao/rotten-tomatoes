//
//  MovieDetailsViewController.m
//  Rotten Tomatoes
//
//  Created by Wes Chao on 10/15/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController{
    // a place to store the navigation bar image
    UIImage *_navBarImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TitleBarWithoutLogo"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TitleBarWithLogo"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // animate the navigation controller
    
    // fade in the image
    self.posterView.alpha = 0.0;
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:2.0];
    self.posterView.alpha = 1.0;
    [UIView commitAnimations];
    
    // set the text
    self.title = [self.movie valueForKeyPath:@"title"];
    self.synopsisLabel.text = [self.movie valueForKeyPath:@"synopsis"];
    [self.synopsisLabel sizeToFit];
    
    // set the poster
    NSString *thumbnailUrl = [self.movie valueForKeyPath:@"posters.detailed"];
    NSString *photoUrl = [thumbnailUrl stringByReplacingOccurrencesOfString: @"tmb" withString:@"ori"];
    
    [self.posterView setImageWithURL:[NSURL URLWithString:photoUrl]];

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
