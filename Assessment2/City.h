//
//  City.h
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface City : NSObject
@property NSString *cityName;
@property NSString *state;
@property UIImage  *image;

-(instancetype)initWithName:(NSString *)cityName andState:(NSString *)state;

-(void)getWikipediaURL;

@end
