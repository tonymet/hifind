//
//  HFDataSource.m
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HFDataSource.h"


@implementation HFDataSource

-(id)init{
	[super init];
	fileRecords = [[NSMutableArray arrayWithCapacity: 256] retain];
	return self;
}

-(id)initWithArray:(NSArray * )fromArray{
	[super init];
	[fromArray retain];
	fileRecords = fromArray;
	return self;
}
-(id)replaceContents:(NSArray * )fromArray{
	[fromArray retain];
	[fileRecords release];
	fileRecords = fromArray;
}

-(int)numberOfRowsInTableView:(NSTableView *)aTableView{
	return [fileRecords count];
}

-(id)tableView:(NSTableView *)aTableView
		objectValueForTableColumn:(NSTableColumn *)aTableColumn
		row:(int)rowIndex{
	NSMutableDictionary *curRecord;
	curRecord = [fileRecords objectAtIndex: rowIndex];
	return [curRecord objectForKey:[aTableColumn identifier]];
}

-(void)appendFromDict:(NSDictionary*)fromDict{
	[fileRecords addObject:fromDict];
}

-(void)appendFromArray:(NSArray*)fromArray{
	//[fromArray retain];
	[fileRecords addObjectsFromArray:fromArray];
}

- (void)dealloc{
	if(fileRecords != nil){
		[fileRecords release];
		fileRecords = nil;
	}
	[super dealloc];
}
@end
