//
//  RTAcronym.h
//  RTAcronyms
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 RahulT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAcronym : NSObject

@property (nonatomic,copy) NSString* longForm;
@property (nonatomic,assign) double frequency;
@property (nonatomic,assign) double usedSince;
@property (nonatomic,strong) NSArray* subLongformsArray;

- (void) fillFromDict:(NSDictionary*)dict;

@end
