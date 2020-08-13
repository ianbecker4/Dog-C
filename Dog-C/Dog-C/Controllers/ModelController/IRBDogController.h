//
//  IRBDogController.h
//  Dog-C
//
//  Created by Ian Becker on 8/13/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class IRBDog;

@interface IRBDogController : NSObject

- (void)fetchDogForSearchTerm:(NSString *)searchTerm
                   completion:(void(^)(IRBDog *))completion;

@end

NS_ASSUME_NONNULL_END
