//
//  CityDetailViewController.m
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "CityDetailViewController.h"
#import "webViewController.h"

@interface CityDetailViewController () <UITextFieldDelegate , CityDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *wikiLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

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

- (IBAction)unwindFromwebView:(UIStoryboardSegue *)sender
{

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

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {

    if ([sender.title isEqualToString:@"Edit"]) {
        sender.title = @"Done";
        self.nameTextField.hidden = NO;
        self.stateTextField.hidden = NO;
    }else {
        sender.title = @"Edit";
        self.nameTextField.hidden = YES;
        self.stateTextField.hidden = YES;
        
        [self saveData];
    }
}


//    if (self.editing) {
//        self.editing = NO;
//        self.nameLabel.hidden = NO;
//        self.stateLabel.hidden = NO;
//        self.nameTextField.hidden = YES;
//        self.stateTextField.hidden = YES;
//        self.city.cityName = self.nameTextField.text;
//        self.city.state = self.stateTextField.text;
//        self.nameLabel.text = self.city.cityName;
//        self.stateLabel.text = self.city.state;
//        sender.title = @"Edit";
//        [self saveData];
//    }
//    else {
//        self.editing = YES;
//        self.nameLabel.hidden = YES;
//        self.stateLabel.hidden = YES;
//        self.nameTextField.hidden = NO;
//        self.stateTextField.hidden = NO;
//        self.nameTextField.text = self.city.cityName;
//        self.stateTextField.text = self.city.state;
//        sender.title = @"Done";
//
//        [self saveData];
//    }

   //self.stateTextField.hidden = !self.stateTextField.hidden;


//}




- (IBAction)onSetTitleButtonPressed:(UIButton *)sender {
    [self.delegate onSetTitlePressed:self.nameLabel.text];
}



/**
 *  WebView Segue
 *
 *  @param segue  To Wiki View Controller
 *  @param sender Detail View Controller
 */
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    webViewController *vc = segue.destinationViewController;
//    vc.cityName = self.city;
//}

/**
 *  Unwind back to previous view controller
 *
 *  @param sender webview controller
 */

#pragma mark - city delegate

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
