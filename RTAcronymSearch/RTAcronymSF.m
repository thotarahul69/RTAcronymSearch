//
//  RTAcronymSF.m
//  RTAcronyms
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 RahulT. All rights reserved.
//

#import "RTAcronymSF.h"
#import "RTAcronym.h"

static NSString* const kSf = @"sf";
static NSString* const kLfs = @"lfs";

@implementation RTAcronymSF

- (id) init
{
    
    self = [super init];
    
    if (self) {
        self.shortForm = @"";
        self.longForms = @[];
        
    }
    return self;
}
- (void) fillFromDict:(NSDictionary*)dict
{
    if (dict != nil) {
        
        if ([dict[kSf] isKindOfClass:[NSString class]] && dict[kSf] != nil) {
            self.shortForm = dict[kSf];
        }
        
        if ([dict[kLfs] isKindOfClass:[NSArray class]] && dict[kLfs] != nil) {
            NSMutableArray* lfs = [NSMutableArray new];
            
            for (id lfData in dict[kLfs]) {
                if ([lfData isKindOfClass:[NSDictionary class]]) {
                    RTAcronym* lfAc = [RTAcronym new];
                    [lfAc fillFromDict:(NSDictionary*)lfData];
                    
                    [lfs addObject:lfAc];
                }
            }
            
            self.longForms = [NSArray arrayWithArray:lfs];
        }
        
    }
}

@end
