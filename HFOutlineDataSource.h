//
//  HFOutlineDataSource.h
//  hifind
//  A datasource for an NSOutlineView
//
//  Created by Anthony Metzidis on 5/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HiFind.h"

@interface HFOutlineDataSource : NSObject {
	NSMutableDictionary *fileRecords;
}
- (void)replaceContentsFrom:(HiFind *)aHiFind;
- (void)replaceContents:(NSDictionary * )fromDict;
- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item;
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;  
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;
- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item;
@end
