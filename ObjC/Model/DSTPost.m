//
//  DSTPost.m
//  ObjC
//
//  Created by Deniz Tutuncu on 2/13/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import "DSTPost.h"

@implementation DSTPost

- (instancetype)initWithAuthor:(NSString *)author title:(NSString *)title ups:(NSInteger)ups commentsCount:(NSInteger)commentsCount thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self) {
        _author = [author copy];
        _title = [title copy];
        _ups = ups;
        _commentsCount = commentsCount;
        _thumbnail = [thumbnail copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    //Get each post fromm the data key
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    NSString *author = dataDictionary[[DSTPost authorKey]];
    NSString *title = dataDictionary[[DSTPost titleKey]];
    NSInteger ups = [dataDictionary[[DSTPost upsKey]] intValue];
    NSInteger commentsCount = [dataDictionary[[DSTPost commentsCountKey]] intValue];
    NSString *thumbnail = dataDictionary[[DSTPost thumbnailKey]];
    
    return [self initWithAuthor:author title:title ups:ups commentsCount:commentsCount thumbnail:thumbnail];
}

+ (NSString *)authorKey
{
    return @"author";
}

+ (NSString *)titleKey
{
    return @"title";
}

+ (NSString *)upsKey
{
    return @"ups";
}

+ (NSString *)commentsCountKey
{
    return @"num_comments";
}

+ (NSString *)thumbnailKey
{
    return @"thumbnail";
}

@end
