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
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property NSString *wiki;


@end

@implementation webViewController

#pragma mark - View Methods
- (void)viewDidLoad {
        [super viewDidLoad];
     self.wiki = [NSString stringWithFormat:@"https://en.wikipedia.org/wiki/%@", self.selectedCity];
    [self loadUrlRequestFromString:[self.wiki stringByReplacingOccurrencesOfString:@" " withString:@"_"]];

}


    -(void)webViewDidStartLoad:(UIWebView *)webView
    {
        self.spinner.hidden = NO;
        [self.spinner startAnimating];

    }

    -(void)webViewDidFinishLoad:(UIWebView *)webView
    {
        [self.spinner stopAnimating];
        self.spinner.hidden = YES;
        
    }
- (IBAction)onCloseButtonTapped:(UIBarButtonItem *)sender {
[[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark -Helper Methods

-(void)loadUrlRequestFromString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end;
