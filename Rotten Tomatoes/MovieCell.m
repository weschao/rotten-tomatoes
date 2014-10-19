//
//  MovieCell.m
//  Rotten Tomatoes
//
//  Created by Wes Chao on 10/15/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        // match the color of the title bar
        self.backgroundColor = [UIColor colorWithRed:58.0/255.0f green:147.0/255.0f blue:36.0/255.0f alpha:1.0f];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}
@end
