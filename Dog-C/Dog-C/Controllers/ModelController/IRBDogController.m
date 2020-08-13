//
//  IRBDogController.m
//  Dog-C
//
//  Created by Ian Becker on 8/13/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import "IRBDogController.h"
#import "IRBDog.h"

static NSString * const baseURLString = @"https://dog.ceo/api/breed";
static NSString * const imageComponent = @"images";
static NSString * const randomComponent = @"random";

@implementation IRBDogController

+ (instancetype)sharedInstance
{
    static IRBDogController * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedInstance = [IRBDogController new];
    });
    
    return sharedInstance;
}

- (void)fetchDogForSearchTerm:(NSString *)searchTerm completion:(void (^)(IRBDog * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:baseURLString];
    NSString * lowercaseSearchTerm = [searchTerm lowercaseString];
    NSURL * breedURL = [baseURL URLByAppendingPathComponent:lowercaseSearchTerm];
    NSURL * imageURL = [breedURL URLByAppendingPathComponent:imageComponent];
    NSURL * finalURL = [imageURL URLByAppendingPathComponent:randomComponent];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching dog from searchTerm: %@", error);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", error.localizedDescription);
        }
        
        if (!data)
        {
            NSLog(@"Error fetching dog data from searchTerm: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary * JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!JSONDictionary || ![JSONDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Error fetching and decoding the JSON dictionary");
            completion(nil);
            return;
        }
        
        IRBDog * dog = [[IRBDog alloc] initWithDictionary:JSONDictionary];
        completion(dog);
    }] resume];
}

- (void)fetchDogImage:(IRBDog *)dog completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL * imageURL = [NSURL URLWithString:dog.message];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", error.localizedDescription);
        }
        
        if (data) {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
    }] resume];
}

@end
