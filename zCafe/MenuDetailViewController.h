//
//  MenuDetailViewController.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/5/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"
@class MenuCell;
@interface MenuDetailViewController : UIViewController
//@property (strong, nonatomic) MenuCell* menuCell;
//-(void) setMenuDetails:(MenuCell *)menuCell;
@property (weak, nonatomic) IBOutlet UIImageView *cafeImageLabel;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderButton;
@property (strong, nonatomic) NSString* cofeeDescription;
@property(strong, nonatomic) NSString* cofeeTitle;
@property (strong, nonatomic) NSString* imageURL;
@property (weak, nonatomic) IBOutlet THLabel *cofeeDescLabel;
@property (strong,nonatomic) NSNumber* menuItemNumber;
@end
