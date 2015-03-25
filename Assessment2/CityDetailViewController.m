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

    {
        //If not in edit mode when button is pressed, enable editing
        if (!self.inEditModeWhenButtonPressed)
        {
            //Enable editing
            self.editButton.title = @"Done";
            //Make sure text fields are empty to beign with
            self.nameTextField.text = @"";
            self.stateTextField.text = @"";
            //sets placeholder text to the current city and state label text
            self.nameTextField.placeholder = self.nameLabel.text;
            self.stateTextField.placeholder = self.stateLabel.text;

        }
        //Only allow changes if both city and state are entered in text fields
        else //if (//([self.nameTextField.text isEqualToString:@""] || [self.stateTextField.text isEqualToString:@""]))
        {
            //Save new input
            self.editButton.title = @"Edit";

            self.nameLabel.text = self.nameTextField.text;
            [self.selectedCity setState: self.nameTextField.text];

            self.stateLabel.text = self.stateTextField.text;
            [self.selectedCity setState: self.stateTextField.text];
        }
        //show text fields when in edit mode
        self.nameTextField.hidden = self.inEditModeWhenButtonPressed;
        self.stateTextField.hidden = self.inEditModeWhenButtonPressed;
        
        self.inEditModeWhenButtonPressed = !self.inEditModeWhenButtonPressed;
    }


}


- (IBAction)onSetTitleButtonTapped:(UIButton *)sender
{
    [self.delegate onSetTitleButtonTapped:
     self.nameLabel.text];
    NSLog(@"%@", self.selectedCity.cityName);

}


@end
