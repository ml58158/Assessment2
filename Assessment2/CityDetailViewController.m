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

@interface CityDetailViewController () <UITextFieldDelegate , CityDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UILabel *wikiLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property BOOL isEditing;

@property NSString *url;

@end

@implementation CityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.nameTextField.text = self.city.cityName;
    self.stateLabel.text = self.stateTextField.text = self.city.state;
    self.wikiLabel.text = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.city.cityName];

    self.imageView.image = self.city.image;

    self.city.delegate = self;

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
    [self saveData];
    return YES;
}

-(IBAction)onWikiLabelTapped:(UITapGestureRecognizer *)tapGestureRecongizer
{
    [self.city getWikipediaURL];
}

#pragma mark - IBActions


/**
 *  Edit Button Logic
 *
 *  @param sender UIBarButtonItem "Edit"
 */

- (IBAction)onEditButtonPressed:(UIButton *)sender {


    if (self.editing) {
        self.editing = YES;
        self.title =@"Done";
        self.nameTextField.hidden = NO;
        self.stateTextField.hidden = NO;
        self.nameLabel.hidden = YES;
        self.stateLabel.hidden = YES;

    } else {
        self.title = @"Edit";
        self.editing = NO;
        self.nameTextField.hidden = YES;
        self.stateTextField.hidden = YES;
        self.nameLabel.hidden = NO;
        self.stateLabel.hidden = NO;
    }
}

/**
 *  WebView Segue
 *
 *  @param segue  To Wiki View Controller
 *  @param sender Detail View Controller
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WikiSegue"]) {
       webViewController  *vc = (webViewController *) segue.destinationViewController;
        vc.urlString = self.url;
    }
}


- (IBAction)unwindFromWebView:(UIStoryboardSegue *)sender
{

}

- (void)wikipediaURLForCity:(NSString *)cityName
{
    self.url = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.city.cityName];

    [self performSegueWithIdentifier:@"WikiSegue" sender:self];
    
}


#pragma mark - Helper Methods


/**
 *  Helper Method to Save Data From Text Fields and commit them to memory.
 */
- (void)saveData
{
    [self.nameTextField resignFirstResponder];
    [self.stateTextField resignFirstResponder];

    if ([self.nameTextField.text length] > 0 && [self.stateTextField.text length] > 0) {
        self.city.cityName = self.nameLabel.text = self.nameTextField.text;
        self.city.state = self.stateLabel.text = self.stateTextField.text;
    }
}

@end
