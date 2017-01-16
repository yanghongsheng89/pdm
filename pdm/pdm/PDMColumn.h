//
//  PDMColumn.h
//  pdm
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

// <o:Column Id="o51">
// <a:ObjectID>41F4548E-941D-4DC5-A78C-FB982A7E237A</a:ObjectID>
// <a:Name>pid</a:Name>
// <a:Code>pid</a:Code>
// <a:CreationDate>1433383841</a:CreationDate>
// <a:Creator>Gao</a:Creator>
// <a:ModificationDate>1433931329</a:ModificationDate>
// <a:Modifier>Gao</a:Modifier>
// <a:Comment>物理主键，自增</a:Comment>
// <a:DataType>bigint</a:DataType>
// <a:Identity>1</a:Identity>
// <a:Column.Mandatory>1</a:Column.Mandatory>
// <a:ExtendedAttributesText>{F4F16ECD-F2F1-4006-AF6F-638D5C65F35E},MYSQL50,102={9480E6AA-83DD-4AA7-9C91-E48F709C29D9},CharSet,0=
// {B314652C-DD43-4F81-8524-6F97A1BAACBA},Collate,0=
//
// </a:ExtendedAttributesText>
// </o:Column>
@interface PDMColumn : NSObject
{
    NSString *name;
    NSString *code;
    NSString *createUser;
    NSString *modifyUser;
    NSString *type;
    NSString *comment;
    NSString *length;
    BOOL isId;
}
@property (readwrite,copy) NSString *name;
@property (readwrite,copy) NSString *code;
@property (readwrite,copy) NSString *createUser;
@property (readwrite,copy) NSString *modifyUser;
@property (readwrite,copy) NSString *type;
@property (readwrite,copy) NSString *comment;
@property (readwrite,copy) NSString *length;
@property (readwrite) BOOL isId;
@end
