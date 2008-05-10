//
//  HiFind.m
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HFDataSource.h"
#import "HiFind.h"

@implementation HiFind
-(id)init{
	theFile = nil;
}

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
	theFile = file;
}

-(NSFileHandle*)readFromFile:(NSString*)fileName{
	NSFileHandle *file;
	file = [NSFileHandle fileHandleForReadingAtPath:fileName];
	return file;
}

-(NSObject*)fileToString:(NSFileHandle*)fromFile{
	NSData *data;
	NSString *string;
    data = [fromFile readDataToEndOfFile];
	[fromFile closeFile];
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	return string;
}

-(NSArray *)currentRecords{
	if(theFile == nil){
		return nil;
	}
	return [self allRecords:theFile];
}

-(NSArray*)allRecords:(NSFileHandle*)fromFile{
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
	//[records autorelease];
	return [records autorelease];
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


