//
//  HFOutlineDataSource.m
//  hifind
//
//  Created by Anthony Metzidis on 5/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HFOutlineDataSource.h"


@implementation HFOutlineDataSource
-(id)init{
	[super init];
	fileRecords = [NSMutableDictionary dictionaryWithCapacity:0];
	return self;
}

-(void)replaceContents:(NSDictionary * )fromDict{
	[fromDict retain];
	//[fileRecords release];
	fileRecords = fromDict;
}

-(void)replaceContentsFrom:(HiFind *)aHiFind{
	[self replaceContents:[aHiFind currentRecordsDictionary]];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item{
	if(item == nil){
		return YES;
	}
	NSArray *matchingLines = [fileRecords objectForKey:item];
	return ( (matchingLines == nil) || ([matchingLines count] == 0) ) ? NO : YES;
}

- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item{
	if(item == nil){
		return [fileRecords count];
	}
	NSArray *matchingLines = [fileRecords objectForKey:item];
	return (matchingLines == nil) ? 0 : [matchingLines count];
}

- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item{
	if(item == nil){
		NSEnumerator *enm = [fileRecords keyEnumerator];
		int i = 0;
		NSString *curFilename;
		for(i = 0; (curFilename = [enm nextObject]) && (i < index); i++);
		return curFilename;
	}
	NSArray *matchingLines = [fileRecords objectForKey:item];
	if(matchingLines == nil)
		return nil;
	return (NSString*)[[matchingLines objectAtIndex:index] objectForKey:@"matching_line"];
}
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item{
	return (NSString*)item;
}
@end
