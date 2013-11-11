//
//  settingsViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/5/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "settingsViewController.h"
#import "zCafeClient.h"

@interface settingsViewController ()

@end

@implementation settingsViewController

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *standardNSUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString* currentUserName = [standardNSUserDefaults stringForKey:@"UserName"];
    self.currentUserTextField.text = currentUserName;
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"coffee_bg.png"]];
    self.welcomeLabel.text = [NSString stringWithFormat:@"Hi %@",currentUserName];
    
    NSString* imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"/userProfileImage.png"];
    if([imagePath isKindOfClass:[NSNull class]] ||
       imagePath==nil || [@"<null>"isEqualToString:imagePath]){
        imagePath = [[NSBundle mainBundle] pathForResource:@"blank_profile" ofType:@"jpg"];
    }
    UIImage *myImage = [UIImage imageWithContentsOfFile:imagePath];
    self.imageView.image = myImage;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(id)sender {
     [self.view endEditing:YES];
}
- (IBAction)updateUserNameButton:(id)sender {
     NSUserDefaults *standardNSUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString* updatedName = self.currentUserTextField.text;
    [standardNSUserDefaults setObject:updatedName forKey:@"UserName"];
    
    NSLog(@"send photo");
    zCafeClient *client = [[zCafeClient alloc]init];
    [client uploadImage];
}

@end
