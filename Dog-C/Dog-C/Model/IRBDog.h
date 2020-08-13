//
//  IRBDog.h
//  Dog-C
//
//  Created by Ian Becker on 8/13/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRBDog : NSObject

@property (nonatomic, copy, readonly) NSString * message;

- (instancetype) initWithMessage:(NSString *)message;

@end

@interface IRBDog (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
