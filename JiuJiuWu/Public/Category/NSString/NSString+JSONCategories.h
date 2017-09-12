//
//  NSString+JSONCategories.h
//  httpTest
//
//  Created by sunjun on 13-6-10.
//  Copyright (c) 2013年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONCategories)

-(id)JSONValue;  //把NSString转化为NSArray或者NSDictionary
@end

@interface NSData (JSONCategories)

-(id)JSONValue;  //把NSData转化为NSArray或者NSDictionary
@end


@interface NSObject (JSONCategories)
-(NSString*)JSONString; //NSArray或者NSDictionary转化为NSString
@end