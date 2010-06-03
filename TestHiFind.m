//
//  TestHiFind.m
//  hifind
//
//  Created by Anthony Metzidis on 6/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TestHiFind.h"


@implementation TestHiFind

-(void)testGrepFiles{
	
	STAssertTrue(true, @"doing nothing really");
}
-(void)testGrepFiles2{
	NSFileHandle *resultsFile = [aHiFind grepFiles:@"*.php" 
			inDirectory:@"/Users/tonym/Documents/workspace/music_tools/music_content_management_tool/htdocs" 
			withRegex:@"require"];
		NSMutableDictionary *resultsDictionary = [aHiFind allRecordsDictionary:resultsFile];
		NSMutableDictionary *match = [resultsDictionary valueForKey:@"/Users/tonym/Documents/workspace/music_tools/music_content_management_tool/htdocs/contentManager/duplicateResolver/resolverTool.php"];
		STAssertTrue([match count] > 1, @"Making sure there's a match");
}
-(void) setUp{
	aHiFind = [[HiFind alloc]init];
}
@end
