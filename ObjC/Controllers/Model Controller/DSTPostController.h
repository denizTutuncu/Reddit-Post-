//
//  DSTPostController.h
//  ObjC
//
//  Created by Deniz Tutuncu on 2/13/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DSTPost;

NS_ASSUME_NONNULL_BEGIN

@interface DSTPostController : NSObject


+ (instancetype)sharedController;

- (void)serchForPostWithSearchTerm:(NSString *)searchTerm completion: (void(^) (NSArray<DSTPost *> *posts, NSError *error))completion;

- (void)fetchImagePost:(DSTPost *)post completion:(void(^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
