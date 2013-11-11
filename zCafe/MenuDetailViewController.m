//
//  MenuDetailViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/5/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "orderDetailViewController.h"
#import "orderDetail.h"
#import "THLabel.h"


#define kShadowColor1		[UIColor blackColor]
#define kShadowColor2		[UIColor colorWithWhite:0.0 alpha:0.75]
#define kShadowOffset		CGSizeMake(0.0, UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 4.0 : 2.0)
#define kShadowBlur			(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 10.0 : 5.0)

#define kStrokeColor		[UIColor blackColor]
#define kStrokeSize			(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 6.0 : 3.0)

#define kGradientStartColor	[UIColor colorWithRed:255.0 / 255.0 green:193.0 / 255.0 blue:127.0 / 255.0 alpha:1.0]
#define kGradientEndColor	[UIColor colorWithRed:255.0 / 255.0 green:163.0 / 255.0 blue:64.0 / 255.0 alpha:1.0]



@interface MenuDetailViewController ()

@end

@implementation MenuDetailViewController

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
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) configureView{
    
    self.cofeeDescLabel.text = self.cofeeDescription;
    self.cofeeDescLabel.layer.cornerRadius = 15;
    
    self.cofeeDescLabel.shadowColor = kShadowColor2;
	self.cofeeDescLabel.shadowOffset = kShadowOffset;
	self.cofeeDescLabel.shadowBlur = kShadowBlur;
////	self.cofeeDescLabel.strokeColor = kStrokeColor;
////	self.cofeeDescLabel.strokeSize = kStrokeSize;
//	self.cofeeDescLabel.gradientStartColor = kGradientStartColor;
//	self.cofeeDescLabel.gradientEndColor = kGradientEndColor;

    
    self.placeOrderButton.layer.cornerRadius = 15;
    self.title = self.cofeeTitle;
    NSURL *url = [NSURL URLWithString:self.imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.cafeImageLabel.image = [[UIImage alloc]initWithData:data];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"coffee_bg.png"]];
    self.cafeImageLabel.layer.masksToBounds = YES;
    self.cafeImageLabel.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    self.cafeImageLabel.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coffee_bg_init.png"]].CGColor;
    self.cafeImageLabel.layer.borderWidth = 10;
}


// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"placeOrderFromDetail"]) {
        orderDetailViewController *placeOrderViewController = [segue destinationViewController];
        NSUserDefaults *standardNSUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString* currentUserName = [standardNSUserDefaults stringForKey:@"UserName"];
        placeOrderViewController.name = currentUserName;
        placeOrderViewController.cofeeTitle = self.cofeeTitle;
        placeOrderViewController.menuItemNumber = self.menuItemNumber;
    }
    
}

@end
