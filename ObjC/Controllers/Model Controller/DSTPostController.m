//
//  DSTPostController.m
//  ObjC
//
//  Created by Deniz Tutuncu on 2/13/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import "DSTPostController.h"
#import "DSTPost.h"
#import <UIKit/UIKit.h>

static NSString * const baseURLString = @"https://www.reddit.com/r/";

@implementation DSTPostController
//Singleton
+ (instancetype)sharedController
{
    static DSTPostController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^ {
        sharedInstance = [[DSTPostController alloc]init];
    });
    return sharedInstance;
}

- (void)serchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<DSTPost *> * , NSError * ))completion
{
    //Built final url
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:searchTerm];
    //searchURL = [ searchURL URLByAppedingPathExtension:@"json"];
    NSURL *finalSearchURL = [searchURL URLByAppendingPathExtension:@"json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalSearchURL completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error: no data returned from task");
            completion(nil, error);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSONDictionary is not a dict class");
            completion(nil, error);
            return;
        }
        
        NSDictionary *postDataDictioneries = jsonDictionary[@"data"];
        NSArray *childrenArray = postDataDictioneries[@"children"];
        //Placeholder for the
        NSMutableArray *postArray = [NSMutableArray array];
        
        for (NSDictionary * dataDictionry in childrenArray) {
            DSTPost *post = [[DSTPost alloc]initWithDictionary:dataDictionry];
            [postArray addObject:post];
        }
        completion(postArray, nil);
    }]resume];
}

- (void)fetchImagePost:(DSTPost *)post completion:(void(^)(UIImage *))completion
{
    NSString *thumbnailString = [[NSString alloc]initWithFormat:@"%@", post.thumbnail];
    NSURL *thumbnailUrl = [[NSURL alloc]initWithString:thumbnailString];
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:thumbnailUrl completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        if (error) {
            NSLog(@"Error handeling image %@", error);
            completion(nil);
            return ;
        }
        if (!data) {
            NSLog(@"Error: no data from image task");
            completion(nil);
            return;
        }
        UIImage *thumbnail = [[UIImage alloc]initWithData:data];
        completion(thumbnail);
    }]resume];
}

@end
