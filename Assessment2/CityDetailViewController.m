//
//  CityDetailViewController.m
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "CityDetailViewController.h"
#import "webViewController.h"
#import "City.h"

@interface CityDetailViewController () <UITextFieldDelegate, UIAlertViewDelegate, DetailDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *wikiLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIButton *titleChange;

@property BOOL inEditModeWhenButtonPressed;

@property NSString *url;

@end

@implementation CityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.nameTextField.text = self.selectedCity.cityName;
    self.stateLabel.text = self.stateTextField.text = self.selectedCity.state;
    self.imageView.image = self.selectedCity.image;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WikiSegue"])
    {
        webViewController *vc = segue.destinationViewController;
        vc.selectedCity = self.selectedCity.cityName;
    }
}


/**
 *  Return Data From Text Field
 *
 *  @param textField City and State Namr
 *
 *  @return method data
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (IBAction)unwindFromwebView:(UIStoryboardSegue *)sender
{

}


-(IBAction)onWikiLabelTapped:(UITapGestureRecognizer *)tapGestureRecongizer
{
    CGPoint point = [tapGestureRecongizer locationInView:self.view];
    if (CGRectContainsPoint(self.wikiLabel.frame, point))
    {
        [self performSegueWithIdentifier:@"WikiSegue" sender:nil];
    }


}

#pragma mark - IBActions


/**
 *  Edit Button Logic
 *
 *  @param sender UIBarButtonItem "Edit"
 */

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {


    if (!self.inEditModeWhenButtonPressed)
    {
        _editButton.title = @"Done";

        self.nameTextField.text = self.nameLabel.text;
        self.stateTextField.text = self.stateLabel.text;


    }
    else
    {
        _editButton.title = @"Edit";
        self.nameLabel.text = self.nameTextField.text;
        self.stateLabel.text = self.stateTextField.text;

        self.selectedCity.cityName = self.nameLabel.text;
        self.selectedCity.state = self.stateLabel.text;




    }
    self.inEditModeWhenButtonPressed = !self.inEditModeWhenButtonPressed;
    self.nameLabel.hidden = !self.nameLabel.hidden;
    self.nameTextField.hidden = !self.nameTextField.hidden;
    self.stateLabel.hidden = !self.stateLabel.hidden;
    self.stateTextField.hidden = !self.stateTextField.hidden;

}



- (IBAction)onSetTitleButtonTapped:(UIButton *)sender
{
    [self.delegate onSetTitleButtonTapped:
     self.nameLabel.text];
    NSLog(@"%@", self.selectedCity.cityName);

}


@end
