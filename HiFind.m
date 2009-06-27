//
//  HiFind.m
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HFDataSource.h"
#import <HiFind/HiFind.h>

@implementation HiFind
-(id)init{
	[super init];
	theFile = nil;
	return self;
}

-(NSFileHandle*)grepFiles:(NSString*)filePattern inDirectory:(NSString*) directoryName
		withRegex:(NSString*)regexPattern{
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
	theFile = file;
	return file;
}

-(NSFileHandle*)readFromFile:(NSString*)fileName{
	NSFileHandle *file;
	file = [NSFileHandle fileHandleForReadingAtPath:fileName];
	return file;
}

-(NSString*)fileToString:(NSFileHandle*)fromFile{
	NSData *data;
	NSString *string;
    data = [fromFile readDataToEndOfFile];
	[fromFile closeFile];
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	return string;
}

-(NSMutableArray *)currentRecords{
	if(theFile == nil){
		return nil;
	}
	return [self allRecords:theFile];
}

-(NSMutableDictionary *)currentRecordsDictionary{
	if(theFile == nil){
		return nil;
	}
	return [self allRecordsDictionary:theFile];
}

-(NSMutableArray*)allRecords:(NSFileHandle*)fromFile{
	NSString *contents;
	contents = [self fileToString: fromFile];
	NSArray *rows;
	// divide file by newlines
	rows = [contents componentsSeparatedByString:@"\n"];
	NSMutableArray *records;
	records = [[NSMutableArray arrayWithCapacity:[rows count]] retain];
	NSDictionary *curRecord;
	NSString *curRow;
	NSEnumerator *enm = [rows objectEnumerator];
	while(curRow = [enm nextObject]){
		curRecord = [[self toRecord:curRow] retain];
		if(curRecord != nil){
			[records addObject:curRecord];
			[curRecord autorelease];
		}
	}
	return [records autorelease];
}

/**
 * Return a mapping of matches as filename => NSMutableArray of matches
 */
-(NSMutableDictionary*)allRecordsDictionary:(NSFileHandle*)fromFile{
	NSString *contents;
	contents = [self fileToString: fromFile];
	NSArray *rows;
	// divide file by newlines
	rows = [contents componentsSeparatedByString:@"\n"];
	NSMutableDictionary *records;
	records = [[NSMutableDictionary dictionaryWithCapacity:[rows count]] retain];
	NSDictionary *curRecord;
	NSString *curRow;
	NSEnumerator *enm = [rows objectEnumerator];
	NSMutableArray *curMatchList;
	NSString *curFileName;
	while(curRow = [enm nextObject]){
		curRecord = [[self toRecord:curRow] retain];
		if(curRecord != nil){
			curFileName = [curRecord objectForKey:@"filename"];
			curMatchList = [records objectForKey:curFileName];
			// build a new MutableArray if no match and add it to filename
			if(curMatchList == nil){
				curMatchList = [NSMutableArray arrayWithObject:curRecord];
				[records setObject:curMatchList forKey:curFileName];
			}
			else{
				[curMatchList addObject:curRecord];
			}
			//[curRecord autorelease];
		}
	}
	return records;
}
	
-(NSDictionary*)toRecord:(NSString*)fromLine{
	NSDictionary *curRecord;
	NSRange rName, rMatchingLine;
	rName = [fromLine rangeOfString:@":"];

	if(rName.location != NSNotFound){
		// copy from beginning of string to location
		rName.length = rName.location;
		rName.location = 0;
		rMatchingLine = NSMakeRange(rName.length + 1,[fromLine length] - rName.length - 1) ;
	}
	else{
		rMatchingLine = NSMakeRange(0, 0);
	}
	
	@try{
		curRecord = [[NSDictionary dictionaryWithObjectsAndKeys:
			[fromLine substringWithRange:rName], @"filename" ,
			[fromLine substringWithRange:rMatchingLine] , @"matching_line" , nil] retain];

	}
	@catch ( NSException  *e){
		NSLog([NSString stringWithFormat:@"Error parsing line %@", fromLine]);
		return nil;
	}
	[curRecord autorelease];
	return curRecord;
}
@end


