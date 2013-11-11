//
//  orderDetail.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderDetail : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *cofeeTitle;
@property (strong,nonatomic) NSNumber *menuItemNumber;
@property (strong,nonatomic) NSNumber *orderNumberInQueue;
@property (strong, nonatomic)NSNumber *orderId;
@property (strong,nonatomic)NSString* notesForOrder;

@end
