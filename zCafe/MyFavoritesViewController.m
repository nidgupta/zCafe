//
//  MyFavoritesViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/4/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "MyFavoritesViewController.h"
#import "FavoriteCell.h"
#import "MenuDetailViewController.h"
#import "orderDetailViewController.h"
#import "zCafeClient.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/CALayer.h>

@interface MyFavoritesViewController ()
 @property (strong, nonatomic) NSMutableArray *favoriteItems;
    
@end

@implementation MyFavoritesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setFavoritesTable];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self setFavoritesTable];
//    [self.tableView reloadData];
}

-(void)setFavoritesTable{
    NSLog(@"set table called");
    zCafeClient *client = [[zCafeClient alloc]init];
    self.favoriteItems = [client getFavorites];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_bg_init.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    [self setFavoritesTable];
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.favoriteItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FavoriteCell";
    FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    NSDictionary* oneitem = [self.favoriteItems objectAtIndex:indexPath.section];
    
    
    cell.cafeTitleLabel.text = [oneitem objectForKey:@"title"];
    cell.cafeDetailLabel.text = [oneitem objectForKey:@"description"];
    NSString *imageURL = [oneitem objectForKey:@"thumbImageUrl"];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [[UIImage alloc]initWithData:data];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    //    cell.imageView.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coffee_bg_init.png"]].CGColor;
    cell.imageView.layer.borderWidth = 10;
    
    [cell.layer setCornerRadius:15.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:2.0f];
    
    [cell.placeorderButton addTarget:self action:@selector(placeOrderbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.placeorderButton.tag=indexPath.section;

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



- (IBAction)placeOrderbuttonTapped:(id)sender {
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showFavoriteDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary* oneitem = [self.favoriteItems objectAtIndex:indexPath.section];
        
        MenuDetailViewController *menuDetailViewController = [segue destinationViewController];
        
        menuDetailViewController.cofeeDescription = [oneitem objectForKey:@"description"];
        menuDetailViewController.cofeeTitle = [oneitem objectForKey:@"title"];
        menuDetailViewController.imageURL = [oneitem objectForKey:@"imageUrl"];
        menuDetailViewController.menuItemNumber = [oneitem objectForKey:@"id"];
    }
    
    if ([[segue identifier] isEqualToString:@"placeOrderFromFavorites"]) {
        
        UIButton *senderButton = (UIButton *)sender;
        NSInteger rowNum = senderButton.tag;

//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDictionary* oneitem = [self.favoriteItems objectAtIndex:indexPath.section];
        NSDictionary* oneitem = [self.favoriteItems objectAtIndex:rowNum];
        orderDetailViewController *placeOrderViewController = [segue destinationViewController];
        NSUserDefaults *standardNSUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString* currentUserName = [standardNSUserDefaults stringForKey:@"UserName"];
        placeOrderViewController.name = currentUserName;
        placeOrderViewController.cofeeTitle = [oneitem objectForKey:@"title"];
        placeOrderViewController.menuItemNumber = [oneitem objectForKey:@"id"];
    }
}

@end
