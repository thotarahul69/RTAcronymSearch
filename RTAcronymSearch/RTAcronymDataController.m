//
//  RTAcronymDataController.m
//  RTAcronyms
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 RahulT. All rights reserved.
//

#import "RTAcronymDataController.h"
#import "RTAcronym.h"
#import "RTAcronymSF.h"

static NSString * const AcronymURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=";

@implementation RTAcronymDataController


+ (instancetype)manager {
    
    return [[self alloc] initWithBaseURL:[NSURL URLWithString:AcronymURLString]];
}

- (void) retrieveAcronymDataForSF:(NSString*)shortform OnCompletion:(void (^)(RTAcronymSF *acronymData, NSError *error))onCompletion
{
   NSString* encodeShortForm = [shortform stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSString* urlSting = [NSString stringWithFormat:@"%@%@",AcronymURLString,encodeShortForm];
    NSURL* url = [NSURL URLWithString:urlSting];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        RTAcronymSF *acronymData = [RTAcronymSF new];
        NSError* jsonError;
        
        // Root is an array
        NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&jsonError];
        NSDictionary* sfDict = jsonArray.firstObject;
        
        [acronymData fillFromDict:sfDict];

        if (jsonError == nil) {
            onCompletion(acronymData, nil);
        }
        else{
            onCompletion(nil,jsonError);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        onCompletion(nil, error);
        
    }];
    [op start];

}

@end
