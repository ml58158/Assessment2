//
//  OverViewController.m
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "OverViewController.h"
#import "CityDetailViewController.h"
#import "City.h"

@interface OverViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *cityArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;
@property BOOL isEditing;

@end

@implementation OverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     City Array
     */
    City *cityOne = [[City alloc]initWithName:@"Greenville" andState:@"SC"];
    City *cityTwo = [[City alloc]initWithName:@"Kingsport" andState:@"TN"];
    City *cityThree = [[City alloc]initWithName:@"Nashville" andState:@"TN"];
    City *cityFour = [[City alloc]initWithName:@"New Orleans" andState:@"LA"];
    City *cityFive = [[City alloc]initWithName:@"Dallas" andState:@"TX"];
    City *citySix = [[City alloc] initWithName:@"Key West" andState:@"FL"];
    City *citySeven = [[City alloc]initWithName:@"Tampa" andState:@"FL"];
    self.cityArray = [NSMutableArray arrayWithObjects:cityOne,cityTwo, cityThree, cityFour,
                      cityFive, citySix, citySeven, nil];

    /**
     *  Sets Editing Function
     */
    //self.editing = FALSE;
}

#pragma mark - Custom Delegate Methods
-(void)changeTitle:(NSString *)newTitle
{
    self.navigationItem.title = newTitle;
}


#pragma mark - UI TableView DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    City *city = [self.cityArray objectAtIndex:indexPath.row];
    cell.textLabel.text = city.cityName;
    cell.detailTextLabel.text = city.state;
    cell.imageView.image = city.image;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityArray.count;
}

/**
 *  Enable/Disable Editing of Tabular Data
 *
 *  @param tableView City Names and Tables
 *  @param indexPath Allow editing of Data
 *
 *  @return YES
 */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/**
 *  Edit Button Logic
 *
 *  @param sender Edit Button
 */
- (IBAction)onEditButtonTapped:(UIButton *)sender
{

    if (!self.isEditing) {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }
    else {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    }
         self.isEditing = !self.isEditing;

}

/**
 *  Move Cell within Table
 *
 *  @param tableView            city data
 *  @param sourceIndexPath      sourceIndexPath.row
 *  @param destinationIndexPath destinationIndexPath.row
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    NSString *cityName = [self.cityArray objectAtIndex:sourceIndexPath.row];
    [self.cityArray removeObject:cityName];
    [self.cityArray insertObject:cityName atIndex:destinationIndexPath.row];
    [self.tableView reloadData];
}


/**
 *  Enable Data changes to commit and save
 *
 *  @param tableView    city TableView
 *  @param editingStyle Allow Deletions
 *  @param indexPath    indexpath.row
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cityArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

#pragma mark - Change Title Delegation

-(void)changeTitleButtonTapped:(NSString *)cityName
{
    self.navigationItem.title = cityName;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        CityDetailViewController *vc = (CityDetailViewController *)segue.destinationViewController;

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        City *city = [self.cityArray objectAtIndex:indexPath.row];
        
        vc.selectedCity = city;
    }
}
@end
