//
//  HiFindController.h
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#import "HiFind.h"
#import "HFDataSource.h"
#import <Cocoa/Cocoa.h>


@interface HiFindController : NSObject {
	IBOutlet NSTextField *filePatternField;
	IBOutlet NSTextField *regexPatternField;
	IBOutlet NSTextField *directoryNameField;
	IBOutlet NSTextView  *resultsView;
	HiFind *aHiFind;
	IBOutlet HFDataSource *aHFDataSource;
	IBOutlet NSTableView *resultsTableView;
}

- (IBAction)search:(id)sender;
- (IBAction)updateDS:(id)sender;
@end
