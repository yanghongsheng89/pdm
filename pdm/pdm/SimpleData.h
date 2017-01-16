//
//  SimpleData.h
//  pdm
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleData : NSObject

{
    NSString *name;
    NSString *age;
}

@property (readwrite,copy) NSString * name;
@property (readwrite,copy) NSString * age; @end
