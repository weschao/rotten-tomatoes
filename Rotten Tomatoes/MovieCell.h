//
//  MovieCell.h
//  Rotten Tomatoes
//
//  Created by Wes Chao on 10/15/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end
