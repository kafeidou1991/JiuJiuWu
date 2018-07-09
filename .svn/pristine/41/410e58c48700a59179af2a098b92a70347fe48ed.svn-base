//
//  NSString+JSONCategories.m
//  httpTest
//
//  Created by sunjun on 13-6-10.
//  Copyright (c) 2013年 sun. All rights reserved.
//

#import "NSString+JSONCategories.h"

@implementation NSString (JSONCategories)

-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end


@implementation NSData (JSONCategories)

-(id)JSONValue
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


@end

@implementation NSObject (JSONCategories)

-(NSString*)JSONString
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    if(result){
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return result;
}
@end