//
//  AppDelegate.h
//  pdm
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSTableView *tableView;
    IBOutlet NSTextFieldCell *systemNameLabel;
    __weak IBOutlet NSOutlineView *menuTableView;
    NSMutableArray *array;
}
//- (void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock;
@end

