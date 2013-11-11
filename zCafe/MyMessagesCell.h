//
//  MyMessagesCell.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/7/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessagesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *dateStampLabel;

@end
