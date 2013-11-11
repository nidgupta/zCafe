//
//  orderDetailViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "orderDetailViewController.h"
#import "orderStatusViewController.h"
#import "zCafeClient.h"
#import "orderDetail.h"

@interface orderDetailViewController ()
@property (strong,nonatomic) orderDetail* orderDetailItem;
@end

@implementation orderDetailViewController

#pragma mark - Managing the detail item


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
- (IBAction)onTap:(id)sender {
     [self.view endEditing:YES];
}

-(void) configureView{
    
    self.orderTitleLabel.text = self.cofeeTitle;
    self.nameLabel.text = self.name;
    
    zCafeClient *client = [[zCafeClient alloc]init];
    NSInteger orderNumber = [client getCurrentQueueCount];
    NSLog(@"print the order number %d",orderNumber);
    self.orderNumber.text = [@(orderNumber) stringValue];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"coffee_bg_init.png"]];
}

- (IBAction)orderConfirmation:(id)sender {
    zCafeClient *client = [[zCafeClient alloc]init];
    self.orderDetailItem = [[orderDetail alloc]init];
    self.orderDetailItem.name = self.name;
    self.orderDetailItem.cofeeTitle = self.cofeeTitle;
    self.orderDetailItem.menuItemNumber = self.menuItemNumber;
    self.orderDetailItem.notesForOrder = self.notesTextField.text;
    [client placeOrder:self.orderDetailItem];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)orderCancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    return;
    
}


@end
