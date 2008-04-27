//
//  HiFind.m
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HiFind.h"


@implementation HiFind


-(NSFileHandle*)grepFilesMatchingPattern:(NSObject*)filePattern inDirectory:(NSObject*) directoryName
		withRegex:(NSObject*)regexPattern{
	NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/bash"];
	
	NSString *cmd;
	cmd = [NSString stringWithFormat:@"find \"%@\" -iname \"%@\" -print0 |xargs -0 egrep \"%@\"",
		directoryName,
		filePattern,
		regexPattern];
	NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-c", cmd, nil];
    [task setArguments: arguments];

    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];

    NSFileHandle *file;
    file = [pipe fileHandleForReading];
	

    [task launch];
	return file;
}

-(NSObject*)fileToString:(NSFileHandle*)fromFile{
	NSData *data;
	NSString *string;
    data = [fromFile readDataToEndOfFile];
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	return string;
}

-(NSArray*)allRecords:(NSFileHandle*)fromFile{
	NSString *contents;
	contents = [self fileToString: fromFile];
	NSArray *rows;
	// divide file by newlines
	rows = [contents componentsSeparatedByString:@"\n"];
	NSMutableArray *records;
	records = [[NSMutableArray alloc] initWithCapacity:[rows count]];
	int i = 0;
	NSDictionary *curRecord;
	NSString *curRow;
	NSArray *curRowParts;
	for(i = 0; i < [rows count]; i++){
		curRow = [rows objectAtIndex: i];
		curRecord = [self toRecord:curRow];
		if(curRecord != nil){
			[records addObject:curRecord];
		}
	}
	return records;
}
-(NSDictionary*)toRecord:(NSString*)fromLine{
	NSArray *curRowParts;
	NSDictionary *curRecord;
	curRowParts = [fromLine componentsSeparatedByString:@":"];
	if([curRowParts count] < 2){
		return nil;
	}
	curRecord = [NSDictionary dictionaryWithObjectsAndKeys:
			[curRowParts objectAtIndex:0] , @"filename" ,
			[curRowParts objectAtIndex:1] , @"matching_line" , nil];
	return curRecord;
}
@end


