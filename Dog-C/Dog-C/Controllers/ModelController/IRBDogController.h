//
//  IRBDogController.h
//  Dog-C
//
//  Created by Ian Becker on 8/13/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBDog.h"
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@class IRBDog;

@interface IRBDogController : NSObject

+ (instancetype)sharedInstance;

- (void)fetchDogForSearchTerm:(NSString *)searchTerm
                   completion:(void(^)(IRBDog *))completion;

- (void)fetchDogImage:(IRBDog *)dog completion:(void(^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
