//
//  HFDataSource.h
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Appkit/NSTableView.h>


@interface HFDataSource : NSObject{
	NSMutableArray *fileRecords;
}
// intialize array
//-(void)init;
-(void)appendRecord:(NSString*)fileName havingLine:(NSString*)matchingLine;
-(void)appendFromDict:(NSDictionary*)fromDict;
-(void)appendFromArray:(NSArray*)fromArray;
-(int)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView
    objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex;
@end
