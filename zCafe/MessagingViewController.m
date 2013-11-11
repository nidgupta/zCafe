//
//  MessagingViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/8/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "MessagingViewController.h"

#import "UIButton+JSMessagesView.h"
#import "JSAvatarImageFactory.h"
#import "zCafeClient.h"


@interface MessagingViewController ()
 @property (strong, nonatomic) NSMutableArray *myMessages;
@end

@implementation MessagingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            [self setMyMessagesTable];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setMyMessagesTable];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    
    self.title = @"Messages";
    
//    [self setMyMessagesTable];
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self setMyMessagesTable];
    [super viewDidAppear:animated];

}

-(void)setMyMessagesTable{
    zCafeClient *client = [[zCafeClient alloc]init];
    self.myMessages = [client getMyMessages];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.myMessages count];
}

#pragma JSMessagesViewDataDelegate protocols
- (void)didSendText:(NSString *)text{
    
    zCafeClient *client = [[zCafeClient alloc]init];
    [client sendMessage:text];
    [self finishSend];
    [self scrollToBottomAnimated:YES];
    [JSMessageSoundEffect playMessageSentSound];
    [self setMyMessagesTable];
    [self.view endEditing:YES];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    NSString* senderName= [oneitem objectForKey:@"name"];

    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString* userName = [standardUserIDDefualts stringForKey:@"UserName"];
    
    if([senderName isEqualToString:userName]){
        return JSBubbleMessageTypeOutgoing;
    }
    else{
        return JSBubbleMessageTypeIncoming;
    }
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    
    NSString* senderName= [oneitem objectForKey:@"name"];
    
    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
    NSString* userName = [standardUserIDDefualts stringForKey:@"UserName"];
    
    if([senderName isEqualToString:userName]){

        return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                          style:JSBubbleImageViewStyleClassicBlue];
    }
    return [JSBubbleImageViewFactory bubbleImageViewForType:type style:JSBubbleImageViewStyleClassicGray];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy{
    return JSMessagesViewTimestampPolicyAll;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy{
    return JSMessagesViewAvatarPolicyAll;
}

- (JSMessagesViewSubtitlePolicy)subtitlePolicy{
    return JSMessagesViewSubtitlePolicyAll;
}

#pragma JSMessagesViewDataSource protocols

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    return [oneitem objectForKey:@"message"];
}
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    return [oneitem objectForKey:@"date"];

}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath*)indexPath{
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    
//    NSString* senderName= [oneitem objectForKey:@"name"];
//    
//    NSUserDefaults *standardUserIDDefualts = [NSUserDefaults standardUserDefaults];
//    NSString* userName = [standardUserIDDefualts stringForKey:@"UserName"];
//    
//    if([senderName isEqualToString:userName]){
//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"nidhi" ofType:@"png"];
//        UIImage *myImage = [UIImage imageWithContentsOfFile:imagePath];
//        NSData *pngImageData = UIImagePNGRepresentation(myImage);
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc]initWithData:pngImageData]];
//        return imageView;
//
//    }
    NSString *imageURL = [oneitem objectForKey:@"photoUrl"];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc]initWithData:data]];
    return imageView;
}

- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath*)indexPath{
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    
    return [oneitem objectForKey:@"name"];

}

//  *** Implement to prevent auto-scrolling when message is added
//
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

@end
