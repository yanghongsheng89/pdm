//
//  PDMTableSymbol.h
//  pdm
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDMTableSymbol : NSObject
{
    NSString *tableRef;
}
@property (readwrite,copy) NSString *tableRef;
@end
