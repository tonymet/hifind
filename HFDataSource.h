//
//  HFDataSource.h
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Appkit/NSTableView.h>
#import "HiFind.h"

@interface HFDataSource : NSObject{
	NSMutableArray *fileRecords;
}
// intialize array
-(id)initWithArray:(NSArray * )fromArray;
-(void)replaceContents:(NSArray * )fromArray;
-(void)replaceContentsFrom:(HiFind *)aHiFind;
-(int)numberOfRowsInTableView:(NSTableView *)aTableView;
-(id)tableView:(NSTableView *)aTableView
    objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex;
@end
