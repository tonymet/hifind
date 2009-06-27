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
	
	STAssertTrue(1, @"doing nothing really");
}
-(void)testGrepFiles2{
	NSFileHandle *resultsFile = [aHiFind grepFiles:@"*.php" 
			inDirectory:"/Users/tonym/Documents/workspace/music_tools/music_content_management_tool/htdocs" 
			withRegex:@"require"];
		NSMutableDictionary *resultsDictionary = [aHiFind allRecordsDictionary:resultsFile];
		NSMutableDictionary *match = [resultsDictionary valueForKey:@"/Users/tonym/Documents/workspace/music_tools/music_content_management_tool/htdocs/contentManager/duplicateResolver/trackSearch.php"];
		STAssertTrue([match objectForKey:@"matching_line"] != nil, @"Making sure there's a match");
}
-(void) setUp{
		aHiFind = [HiFind init];
}
@end
