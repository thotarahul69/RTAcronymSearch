//
//  RTAcronym.m
//  RTAcronyms
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 RahulT. All rights reserved.
//

#import "RTAcronym.h"


static NSString* const kLf = @"lf";
static NSString* const kVars = @"vars";
static NSString* const kFreq = @"freq";
static NSString* const kSince = @"since";

@implementation RTAcronym

- (id) init
{
    
    self = [super init];
    
    if (self) {
        self.longForm = @"";
        self.frequency = 0.0;
        self.usedSince = 0.0;
        self.subLongformsArray = @[];
        
    }
    
    return self;
}


- (void) fillFromDict:(NSDictionary*)dict
{
    if (dict[kLf] != nil && dict[kFreq] != nil && dict[kSince] != nil) {
        
        self.longForm = dict[kLf];
        self.frequency = [dict[kFreq] doubleValue];
        self.usedSince = [dict[kSince] doubleValue];
    }
    
    if (dict[kVars] != nil && [dict[kVars] isKindOfClass:[NSArray class]]) {
        NSMutableArray* slfs = [NSMutableArray new];
        for (id slfData in dict[kVars]) {
            if ([slfData isKindOfClass:[NSDictionary class]]) {
                RTAcronym* slfModel = [RTAcronym new];
                [slfModel fillFromDict:(NSDictionary*)slfData];
                
                [slfs addObject:slfModel];
                
            }
        }
        self.subLongformsArray = [NSArray arrayWithArray:slfs];
    }
}

@end
