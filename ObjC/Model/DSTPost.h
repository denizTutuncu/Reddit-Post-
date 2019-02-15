//
//  DSTPost.h
//  ObjC
//
//  Created by Deniz Tutuncu on 2/13/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSTPost : NSObject

@property (nonatomic, copy, readonly) NSString *author;
@property (nonatomic, copy, readonly) NSString * title;
@property (nonatomic, readonly) NSInteger ups;
@property (nonatomic, readonly) NSInteger commentsCount;
@property (nonatomic, copy, readonly) NSString *thumbnail;


- (instancetype)initWithAuthor: (NSString *)author
                         title: (NSString *)title
                           ups: (NSInteger)ups
                  commentsCount: (NSInteger)commentsCount
                     thumbnail: (NSString *)thumbnail; 

- (instancetype)initWithDictionary: (NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
