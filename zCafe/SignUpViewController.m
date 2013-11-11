//
//  SignUpViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "SignUpViewController.h"
#import "MenuViewController.h"
#import "zCafeClient.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"coffee_bg.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(id)sender {
     [self.view endEditing:YES];
}

- (IBAction)signUpUser:(id)sender {
    // save this name and device id in DB
    zCafeClient *client = [[zCafeClient alloc]init];
     NSString *UDID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString* currentUserName =self.NameTextLabel.text;
    [client registerUser:UDID username:currentUserName];
    
    NSUserDefaults* standardNSUserDefault = [NSUserDefaults standardUserDefaults];
    [standardNSUserDefault setObject:UDID forKey:@"DeviceUDID"];
    [standardNSUserDefault setObject:currentUserName forKey:@"UserName"];

    [client uploadImage];
    MenuViewController *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    [self presentViewController:mainView animated:YES completion:nil];
    
}

@end
