//
//  MenuCell.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cafeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cafeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cafeImageView;
@property (weak, nonatomic) IBOutlet UIButton *cafeOrderButton;

@end
