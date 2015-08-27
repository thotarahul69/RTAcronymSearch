//
//  RTAcronymSF.h
//  RTAcronyms
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 RahulT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAcronymSF : NSObject

@property (nonatomic,copy) NSString* shortForm;
@property (nonatomic,strong) NSArray* longForms;

- (void) fillFromDict:(NSDictionary*)dict;
@end
