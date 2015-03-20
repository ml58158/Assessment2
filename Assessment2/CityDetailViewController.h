//
//  CityDetailViewController.h
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol DetailDelegate <NSObject>

-(void)onSetTitlePressed:(NSString *)title;

@end

@interface CityDetailViewController : UIViewController

@property City *city;
@property (weak, nonatomic) id<DetailDelegate> delegate;

@end
