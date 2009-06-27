//
//  HFDataSource.h
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Appkit/NSTableView.h>
#import <HiFind/HiFind.h>

@interface HFDataSource : NSObject{
	NSMutableArray *fileRecords;
}
// intialize array
-(id)initWithArray:(NSMutableArray * )fromArray;
-(void)replaceContents:(NSMutableArray * )fromArray;
-(void)replaceContentsFrom:(HiFind *)aHiFind;
-(int)numberOfRowsInTableView:(NSTableView *)aTableView;
-(id)tableView:(NSTableView *)aTableView
    objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex;
@end
