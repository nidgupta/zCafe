//
//  ConnectViewController.m
//  zCafe
//
//  Created by Nidhi Gupta on 11/7/13.
//  Copyright (c) 2013 zynga. All rights reserved.
//

#import "ConnectViewController.h"
#import "zCafeClient.h"
#import "MyMessagesCell.h"

@interface ConnectViewController ()

 @property (strong, nonatomic) NSMutableArray *myMessages;
@end

@implementation ConnectViewController

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
 //   [self setMyMessagesTable];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
  //      [self setMyMessagesTable];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setMyMessagesTable];
    [self.tableView reloadData];
}

-(void)setMyMessagesTable{
    zCafeClient *client = [[zCafeClient alloc]init];
    self.myMessages = [client getMyMessages];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return [self.myMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyMessagesCell";
    MyMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"is it here to get first row item?");
    
    NSDictionary* oneitem = [self.myMessages objectAtIndex:indexPath.row];
    
    
    cell.nameLabel.text = [oneitem objectForKey:@"name"];
    cell.dateStampLabel.text = [oneitem objectForKey:@"date"];
    cell.messageTextLabel.text = [oneitem objectForKey:@"message"];
//    NSString *imageURL = [oneitem objectForKey:@"photoUrl"];
//    NSURL *url = [NSURL URLWithString:imageURL];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    cell.imageView.image = [[UIImage alloc]initWithData:data];

    return cell;
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

//// In a story board-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showFavoriteDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDictionary* oneitem = [self.favoriteItems objectAtIndex:indexPath.row];
//        
//        MenuDetailViewController *menuDetailViewController = [segue destinationViewController];
//        
//        menuDetailViewController.cofeeDescription = [oneitem objectForKey:@"description"];
//        menuDetailViewController.cofeeTitle = [oneitem objectForKey:@"title"];
//        menuDetailViewController.imageURL = [oneitem objectForKey:@"imageUrl"];
//        menuDetailViewController.menuItemNumber = [oneitem objectForKey:@"id"];
//    }
//}



@end
