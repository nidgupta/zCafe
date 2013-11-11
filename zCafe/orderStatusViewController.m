//
//  orderStatusViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "orderStatusViewController.h"
#import "OrderStatusCell.h"
#import "zCafeClient.h"
#import "orderDetail.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/CALayer.h>

@interface orderStatusViewController ()
@property (strong, nonatomic) NSMutableArray *orderItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSIndexPath* selectedIndexPath;
@end

@implementation orderStatusViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
	
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_bg_init.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    [self setOrderTable];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self setOrderTable];
//    [self.tableView reloadData];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setOrderTable];
    return self;
}


-(void)setOrderTable{
    zCafeClient *client = [[zCafeClient alloc]init];
    self.orderItems = [client getAllOrdersWithStatus ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.orderItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderStatus" forIndexPath:indexPath];
    
    NSDictionary* orderDetail = [self.orderItems objectAtIndex:indexPath.section];
   // cell.nameLabel.text = [orderDetail objectForKey:@"userName"];
    NSString *imageURL = [[orderDetail objectForKey:@"menu"] objectForKey:@"thumbImageUrl"];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [[UIImage alloc]initWithData:data];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    cell.imageView.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coffee_bg_init.png"]].CGColor;
    cell.imageView.layer.borderWidth = 10;
    
    cell.cofeetitleLabel.text = [[orderDetail objectForKey:@"menu"] objectForKey:@"imageName"];
    cell.cofeeStatusLabel.text = [NSString stringWithFormat:@"Status - %@",[orderDetail objectForKey:@"status"]];
    
    [cell.layer setCornerRadius:15.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:2.0f];

    if([[orderDetail objectForKey:@"queue"] isKindOfClass:[NSNull class]] ||
       [orderDetail objectForKey:@"queue"]==nil ||
       [@"<null>"isEqualToString:[orderDetail objectForKey:@"queue"]] ){
        cell.CancelOrderButton.hidden = YES;
        cell.orderInQueueLabel.text = @"";
    }
    else{
        cell.orderInQueueLabel.text = [NSString stringWithFormat:@"In Queue at %@",[orderDetail objectForKey:@"queue"]];
        cell.CancelOrderButton.hidden = NO;
    }
//    cell.orderInQueueLabel.text = [NSString stringWithFormat:@"In Queue at %@",[orderDetail objectForKey:@"queue"]];
    
    [cell.CancelOrderButton addTarget:self action:@selector(cancelOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.CancelOrderButton.tag=indexPath.section;
    
//    tableView.backgroundColor = [UIColor clearColor];
    
//    UIImage *stretchableImage = [UIImage imageNamed:@"coffee_bg_init.png"];
//    UIImage *cellImage = [stretchableImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
//    imageView.image = cellImage;
//    cell.backgroundView = imageView;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Store the selected indexPath
    self.selectedIndexPath = indexPath;
    
    NSLog(@"row at index path %@ and row %ld",self.selectedIndexPath, (long)self.selectedIndexPath.section);
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

- (IBAction)cancelOrderButton:(id)sender {
    
    UIButton *senderButton = (UIButton *)sender;
    NSInteger rowNum = senderButton.tag;
    
    zCafeClient *client = [[zCafeClient alloc]init];
    NSDictionary* orderDetails = [self.orderItems objectAtIndex:rowNum];
    orderDetail *orderDetailItem = [[orderDetail alloc]init];
    
    orderDetailItem.orderId = [orderDetails objectForKey:@"id"];
    [client cancelOrder:orderDetailItem];
    [self setOrderTable];
    [self.tableView reloadData];
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return NO;
//}
//

@end
