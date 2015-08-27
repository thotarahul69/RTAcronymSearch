//
//  RTAcronymDataController.h
//  RTAcronyms
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 RahulT. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@class RTAcronymSF;

@interface RTAcronymDataController : AFHTTPRequestOperationManager


- (void) retrieveAcronymDataForSF:(NSString*)shortform OnCompletion:(void (^)(RTAcronymSF *acronymData, NSError *error))onCompletion;

@end
