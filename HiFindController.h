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
	IBOutlet NSTextView  *resultsView;
	HiFind *aHiFind;
	IBOutlet HFDataSource *aHFDataSource;
	IBOutlet NSBrowser	 *directoryBrowser;
	IBOutlet NSTableView *resultsTableView;
	IBOutlet NSPopUpButton *directorySelect;
	NSOpenPanel *aDirectoryChooser;
}

- (IBAction)updateDS:(id)sender;
- (IBAction)chooseDirectory:(id)sender;
@end
