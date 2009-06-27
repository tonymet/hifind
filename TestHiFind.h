//
//  TestHiFind.h
//  hifind
//
//  Created by Anthony Metzidis on 6/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <HiFind/HiFind.h>

@interface TestHiFind : SenTestCase {
HiFind *aHiFind;
}
- (void) testGrepFiles;
- (void) testGrepFiles2;
- (void) setUp;

@end
