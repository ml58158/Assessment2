//
//  City.m
//  Assessment2
//
//  Created by Matt Larkin on 3/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "City.h"

@implementation City

-(instancetype)initWithName:(NSString *)cityName andState:(NSString *)state
{

    self = [super init];
    if (self) {
        self.cityName = cityName;
        self.state = state;
        self.image = [UIImage imageNamed:cityName];
    }
    return self;
}

-(void)getWikipediaURL
{
    [self.delegate wikipediaURLForCity:self.cityName];
}

@end
