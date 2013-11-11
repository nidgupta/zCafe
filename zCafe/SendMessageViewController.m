//
//  SendMessageViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/7/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "SendMessageViewController.h"
#import "zCafeClient.h"

@interface SendMessageViewController ()
@property (strong,nonatomic) NSString* myMessage;
@end

@implementation SendMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)messageCancelButtonPressed:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)messageSendButtonPressed:(id)sender {
    zCafeClient *client = [[zCafeClient alloc]init];
    self.myMessage = self.InputMessageTextField.text;
    [client sendMessage:self.myMessage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
