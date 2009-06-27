//
//  HiFind.h
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HiFind : NSObject {
NSFileHandle* theFile;

}

-(NSFileHandle*)grepFiles:(NSObject*)filePattern inDirectory:(NSObject*) directoryName
		withRegex:(NSObject*)regexPattern;
-(NSMutableArray *)allRecords:(NSFileHandle*)fromFile;
-(NSMutableDictionary*)allRecordsDictionary:(NSFileHandle*)fromFile;
-(NSMutableArray *)currentRecords;
-(NSMutableDictionary *)currentRecordsDictionary;
-(NSString*)fileToString:(NSFileHandle*)fromFile;
-(NSDictionary*)toRecord:(NSString*)fromLine;
-(NSFileHandle*)readFromFile:(NSString*)fileName;
@end
