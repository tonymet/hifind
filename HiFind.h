//
//  HiFind.h
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HiFind : NSObject {}

-(NSFileHandle*)grepFilesMatchingPattern:(NSObject*)filePattern inDirectory:(NSObject*) directoryName
		withRegex:(NSObject*)regexPattern;
-(NSArray*)allRecords:(NSFileHandle*)fromFile;
-(NSObject*)fileToString:(NSFileHandle*)fromFile;
@end
