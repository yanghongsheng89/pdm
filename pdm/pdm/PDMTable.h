//
//  PDMTable.h
//  pdm
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDMColumn.h"
@interface PDMTable : NSObject
{
    NSString *name;
    NSString *code;
    NSString *createUser;
    NSString *modifyUser;
    NSArray *pdmColumn;
}
@property (readwrite,copy) NSString *name;
@property (readwrite,copy) NSString *code;
@property (readwrite,copy) NSString *createUser;
@property (readwrite,copy) NSString *modifyUser;
@property (readwrite,copy) NSArray *pdmColumn;
@end
