//
//  zCafeClient.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "zCafeClient.h"

@implementation zCafeClient

-(id) init{
    self = [super initWithBaseURL:[NSURL URLWithString:@"https://yipbb.corp.zynga.com"]];
    if(self){
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return self;
}

-(NSMutableArray *) getMenu{
    
    NSStringEncoding *encoding = NULL;
    NSError *error;
    
    NSURL *url = [NSURL URLWithString:@"https://yipbb.corp.zynga.com/zcafe-api/menu.json"];
    NSString *result = [[NSString alloc] initWithContentsOfURL:url usedEncoding:encoding error:&error];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    //
    NSError *e;
    NSMutableArray *menuItemList = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"jsonList: %@", menuItemList);

    return menuItemList;
//    [self getPath:@"/zcafe-api/menu.json" parameters:@{@"UDID":@"Nidhi"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"success block : %@", responseObject);
//        
//        if([responseObject isKindOfClass:[NSString class]]){
//            NSLog(@"yes it is string");
//        }
//        if([responseObject isKindOfClass:[NSData class]]){
//            NSLog(@"yes it is NSDATA");
//        }
        
//        NSString *jsonString = @"[{\"id\": \"1\", \"name\":\"Aaa\"}, {\"id\": \"2\", \"name\":\"Bbb\"}]";
//        NSLog(@"string here %@",jsonString);
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"failure block %@",error);
//    }];
}

-(void) registerUser:(NSString *)UDID username:(NSString *)userName{
  
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UAID = [standardUserIDDefualts stringForKey:@"DeviceToken"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://yipbb.corp.zynga.com/zcafe-api/register.json"]];
    
    NSLog(@"UAID is here %@",UAID);
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 userName, @"name",
                                 UDID, @"udid",
                                 @"test", @"uaid",
                                 @"ios",@"device",
                                 nil];
    NSLog(@"post data %@",requestData);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) placeOrder:(orderDetail *)orderDetail{
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://yipbb.corp.zynga.com/zcafe-api/orders.json"]];
    
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];
    
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 orderDetail.name, @"userName",
                                 orderDetail.menuItemNumber, @"menuId",
                                 @"1", @"count",
                                 UDID,@"udid",
                                 orderDetail.notesForOrder,@"notes",
                                 nil];
    NSLog(@"post data %@",requestData);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

-(void)cancelOrder:(orderDetail *)orderDetail{
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://yipbb.corp.zynga.com/zcafe-api/cancelOrder.json"]];
    
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];
    NSString* userName = [standardUserIDDefualts stringForKey:@"UserName"];
    
    NSLog(@"here si the UDID %@ and here si the orderId %@",UDID,orderDetail.orderId);
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 userName, @"userName",
                                 UDID,@"udid",
                                 orderDetail.orderId, @"orderId",
                                 nil];
    NSLog(@"post data %@",requestData);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}


-(NSMutableArray *)getAllOrdersWithStatus{
    
    NSStringEncoding *encoding = NULL;
    NSError *error;
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];

    NSString *baseURL = @"https://yipbb.corp.zynga.com/zcafe-api/orders/";
    NSString * stringURL = [NSString stringWithFormat:@"%@%@", baseURL,UDID];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSString *result = [[NSString alloc] initWithContentsOfURL:url usedEncoding:encoding error:&error];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    //
    NSError *e;
    NSMutableArray *orderDetails = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"jsonList: %@", orderDetails);

    return orderDetails;
}

-(NSMutableArray *)getFavorites{
    NSStringEncoding *encoding = NULL;
    NSError *error;
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];

    NSString *baseURL = @"https://yipbb.corp.zynga.com/zcafe-api/menu/";
    NSString * stringURL = [NSString stringWithFormat:@"%@%@", baseURL,UDID];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSString *result = [[NSString alloc] initWithContentsOfURL:url usedEncoding:encoding error:&error];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    //
    NSError *e;
    NSMutableArray *orderDetails = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"jsonList: %@", orderDetails);
    
    return orderDetails;

}

-(NSInteger) getCurrentQueueCount{
    
    NSStringEncoding *encoding = NULL;
    NSError *error;
    
    NSURL *url = [NSURL URLWithString:@"https://yipbb.corp.zynga.com/zcafe-api/queueCount.json"];
    NSString *result = [[NSString alloc] initWithContentsOfURL:url usedEncoding:encoding error:&error];
    NSLog(@"queucount %@",result);
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    //
    NSError *e;
    NSMutableDictionary *queueCount = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSString* counter = [queueCount objectForKey:@"count"];
    
    return [counter integerValue];
 }

-(NSMutableArray *)getMyMessages{
    NSStringEncoding *encoding = NULL;
    NSError *error;
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];
    
    NSString *baseURL = @"https://yipbb.corp.zynga.com/zcafe-api/connects/";
    NSString * stringURL = [NSString stringWithFormat:@"%@%@", baseURL,UDID];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSLog(@"lets get this messages form zclient %@",UDID);
    NSString *result = [[NSString alloc] initWithContentsOfURL:url usedEncoding:encoding error:&error];
    NSLog(@"what si the result of zclient %@",result);
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e;
    NSMutableArray *myMessages = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"jsonList: %@", myMessages);
    
    return myMessages;
    
}

-(void) sendMessage:(NSString *) myMessage{
    
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];
    NSString* userName = [standardUserIDDefualts stringForKey:@"UserName"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://yipbb.corp.zynga.com/zcafe-api/connects.json"]];
    
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 userName, @"name",
                                 UDID, @"udid",
                                 myMessage, @"message",
                                 nil];
    NSLog(@"post data %@",requestData);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)uploadImage{
    
    NSStringEncoding *encoding = NULL;
    NSError *error;
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString *UDID = [standardUserIDDefualts stringForKey:@"DeviceUDID"];
    
    NSString *baseURL = @"https://yipbb.corp.zynga.com/zcafe-api/profileImage/";
    NSString * stringURL = [NSString stringWithFormat:@"%@%@.json", baseURL,UDID];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:url];
    // COnvert Image to NSData
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"nidhi" ofType:@"png"];
    UIImage *myImage = [UIImage imageWithContentsOfFile:imagePath];
    NSData *pngImageData = UIImagePNGRepresentation(myImage);
    // set your Image Name
    NSString *filename = @"Nidhipicture";
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.png\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:pngImageData]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    // Get Response of Your Request
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

//    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 @"file", @"file",
//                                 nil];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    [request setHTTPBody:postData];
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    
}




@end
