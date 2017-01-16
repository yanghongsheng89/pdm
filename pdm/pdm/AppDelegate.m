//
//  AppDelegate.m
//  pdm
//
//  Created by Jack on 2017/1/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AppDelegate.h"
#import "SimpleData.h"
#import "GDataXMLNode.h"
#import "PDMModel.h"
#import "PDMTable.h"
#import "PDMColumn.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    array = [NSMutableArray new];
//    [tableView reloadData];
    [self parsePDM:@"/Users/jack/doc/a.pdm"];
}
-(void) parseXML:(NSString *) path{
    [array removeAllObjects];
    NSData* data=[NSData dataWithContentsOfFile:path];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement *root = [doc rootElement];
    NSArray *arr = [root nodesForXPath:@"//person" error:nil];
    for (GDataXMLElement *ele in arr) {
        NSArray *nameNode = [ele nodesForXPath:@"name" error:nil];
        NSArray *ageNode = [ele nodesForXPath:@"age" error:nil];
        SimpleData * dat = [[SimpleData alloc]init];
        NSString *name = [[nameNode objectAtIndex:0]stringValue];
        NSString *age = [[ageNode objectAtIndex:0]stringValue];
        dat.name = name;
        dat.age = age;
        [array addObject:dat];
    }
}

- (IBAction)openfFile:(id)sender {
    int i;
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanChooseDirectories:YES];
    if ( [openDlg runModalForDirectory:nil file:nil] == NSFileHandlingPanelOKButton )
    {
        NSArray* files = [openDlg filenames];
        
        for( i = 0; i < [files count]; i++ )
        {
            NSString* fileName = [files objectAtIndex:i];
            [self parseXML:fileName];
            [tableView reloadData];
        }
    }
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}
-(void)dealloc
{
    
}

//------------------------protocol----------------------------------

//返回表格的行数
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
{
    return [array count];
}

- (NSView *)tableView:(NSTableView *)tableV viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    id idName = [tableColumn identifier];
    NSTableCellView *cell = [tableV makeViewWithIdentifier:idName owner:self];
    SimpleData * data = [array objectAtIndex:row];
    if ([idName isEqualToString:@"name"]) {
        [cell.textField setStringValue:data.name];
    }else if ([idName isEqualToString:@"age"]) {
        [cell.textField setStringValue:data.age];
    }
    return cell;
}

//-------------------------pdm parser----------------------------------
-(void) parsePDM:(NSString *) path{
    [array removeAllObjects];
    NSData* data=[NSData dataWithContentsOfFile:path];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement *root = [doc rootElement];
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"object",@"o",@"attribute",@"a",@"collection",@"c", nil];
    //--------------table--------------
    NSArray *arr = [root nodesForXPath:@"//c:Tables/o:Table" namespaces:dic error:nil];
    PDMModel * model = [[PDMModel alloc]init];
    NSMutableArray *pdmTables = [[NSMutableArray alloc]init];
    for (GDataXMLElement *ele in arr) {
        PDMTable *table = [[PDMTable alloc]init];
        table.name =[[[ele elementsForName:@"a:Name"] objectAtIndex:0]stringValue];
        table.code = [[[ele elementsForName:@"a:Code"] objectAtIndex:0]stringValue];
        table.createUser = [[[ele elementsForName:@"a:Creator"] objectAtIndex:0]stringValue];
        table.modifyUser = [[[ele elementsForName:@"a:Modifier"] objectAtIndex:0]stringValue];
        NSArray *columns = [[[ele elementsForName:@"c:Columns"] objectAtIndex:0] elementsForName:@"o:Column"];
        NSMutableArray *pdmColumns = [[NSMutableArray alloc]init];
        for (GDataXMLElement *colum in columns) {
            PDMColumn *column = [[PDMColumn alloc]init];
            column.name =[[[colum elementsForName:@"a:Name"] objectAtIndex:0]stringValue];
            column.code = [[[colum elementsForName:@"a:Code"] objectAtIndex:0]stringValue];
            column.createUser = [[[colum elementsForName:@"a:Creator"] objectAtIndex:0]stringValue];
            column.modifyUser = [[[colum elementsForName:@"a:Modifier"] objectAtIndex:0]stringValue];
            column.type = [[[colum elementsForName:@"a:DataType"] objectAtIndex:0]stringValue];
            column.length = [[[colum elementsForName:@"a:Length"] objectAtIndex:0]stringValue];
            [pdmColumns addObject:column];
        }
        table.pdmColumn = pdmColumns;
        [pdmTables addObject:table];
    }
    //----------------------model-------------------------------------
    
    GDataXMLElement *modelNode = [[root nodesForXPath:@"/Model/o:RootObject/c:Children/o:Model" namespaces:dic error:nil] objectAtIndex:0];
    model.name =[[[modelNode elementsForName:@"a:Name"] objectAtIndex:0]stringValue];
    model.code = [[[modelNode elementsForName:@"a:Code"] objectAtIndex:0]stringValue];
    model.createUser = [[[modelNode elementsForName:@"a:Creator"] objectAtIndex:0]stringValue];
    model.modifyUser = [[[modelNode elementsForName:@"a:Modifier"] objectAtIndex:0]stringValue];
    model.pdmTable =pdmTables;
    [systemNameLabel setStringValue:model.name];
}
@end
