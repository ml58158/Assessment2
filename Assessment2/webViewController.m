//
//  webViewController.m
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "webViewController.h"
#import "OverViewController.h"
#import "CityDetailViewController.h"
#import "City.h"

@interface webViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end

@implementation webViewController

#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;

    [self goToURLWithString:[self generateProperStringForURL]];

}

#pragma mark - Delegate Methods

//starting spinner when loading
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.spinner.hidden = NO;
    [self.spinner startAnimating];

}

//ending spinner when finished loading
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
}


#pragma mark - IBActions
//back button pressed - dismisses current view
- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Helper Methods
//Helper method: Loads page using URL string
- (void) goToURLWithString:(NSString *)string
{
    if (![string hasPrefix:@"http://"])
    {
        string = [NSString stringWithFormat:@"http://%@", string];
    }

    NSURL *addressUrl = [NSURL URLWithString:string];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressUrl];
    [self.webView loadRequest:addressRequest];

}

//helper method: replaces black spaces with underlines in order to get to the correct URL
-(NSString *)generateProperStringForURL
{
    NSString * string1 = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.cityName.cityName];
    NSString * returnString = [string1 stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return returnString;
    
}
@end;
