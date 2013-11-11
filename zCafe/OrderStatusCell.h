//
//  OrderStatusCell.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cofeeImageView;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cofeetitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cofeeStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderInQueueLabel;
@property (weak, nonatomic) IBOutlet UIButton *CancelOrderButton;

@end
