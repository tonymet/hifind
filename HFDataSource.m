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
	fileRecords = [[NSMutableArray alloc] initWithCapacity: 256];
	return self;
}

-(void)appendRecord:(NSString*) fileName havingLine:(NSString*)matchingLine{
	NSDictionary *curRecord;
	curRecord = [NSDictionary dictionaryWithObjectsAndKeys:fileName,@"filename",matchingLine,@"matching_line",nil];
	// append the record to fileRecords
	[fileRecords addObject:curRecord];
	
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
	[fileRecords addObjectsFromArray:fromArray];
}
@end
