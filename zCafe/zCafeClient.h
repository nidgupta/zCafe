//
//  zCafeClient.h
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import <AFHTTPClient.h>
#import <AFNetworking.h>
#import "orderDetail.h"

@interface zCafeClient : AFHTTPClient

-(NSMutableArray *) getMenu;

-(void) registerUser:(NSString *)UDID username:(NSString*) userName;

-(void) placeOrder:(orderDetail *) orderDetail;

-(void) cancelOrder:(orderDetail *) orderDetail;

-(NSMutableArray *) getAllOrdersWithStatus;

-(NSMutableArray *) getFavorites;

-(NSInteger) getCurrentQueueCount;

-(NSMutableArray *)getMyMessages;

-(void) sendMessage:(NSString *) myMessage;

-(void)uploadImage;

@end
