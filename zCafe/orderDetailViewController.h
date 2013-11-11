//
//  orderDetailViewController.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderDetail.h"

@interface orderDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *orderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property(strong, nonatomic) NSString* cofeeTitle;
@property (strong, nonatomic) NSString* name;
@property (strong,nonatomic) NSNumber *menuItemNumber;
@property (weak, nonatomic) IBOutlet UIButton *confirmOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;
@end
