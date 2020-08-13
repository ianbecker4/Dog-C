//
//  IRBDog.m
//  Dog-C
//
//  Created by Ian Becker on 8/13/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import "IRBDog.h"

@implementation IRBDog

-(instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self)
    {
        _message = message;
    }
    return self;
}

@end

@implementation IRBDog (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString * message = dictionary[@"message"];
    
    return [self initWithMessage:message];
}

@end
