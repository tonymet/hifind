//
//  HiFindController.m
//  hifind
//
//  Created by Anthony Metzidis on 4/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "HiFindController.h"


@implementation HiFindController

-(id)init{
	[super init];
	aHiFind = [[HiFind alloc]init];
	aDirectoryChooser = [[NSOpenPanel openPanel] retain];
	[aDirectoryChooser setCanChooseFiles:NO];
	[aDirectoryChooser setCanChooseDirectories:YES];
	[aDirectoryChooser setAllowsMultipleSelection:NO];
	[aDirectoryChooser setTitle:@"Choose a Directory"];
	return self;
}

-(IBAction)updateDS:(id)sender{
	[aHiFind grepFilesMatchingPattern:[filePatternField stringValue] 
			inDirectory:[directorySelect titleOfSelectedItem] 
			withRegex:[regexPatternField stringValue]
	];
	[aHFDataSource replaceContentsFrom:aHiFind];
	[resultsTableView reloadData];
}
- (IBAction)updateDSOutline:(id)sender{
	[aHiFind grepFilesMatchingPattern:[filePatternField stringValue] 
			inDirectory:[directorySelect titleOfSelectedItem] 
			withRegex:[regexPatternField stringValue]
	];
	[aHFOutlineDataSource replaceContentsFrom:aHiFind];
	[resultsOutlineTableView reloadData];
}

- (IBAction)chooseDirectory:(id)sender{
	int result = nil;
	NSMenuItem *curMenuItem;
	NSString *selectedFile;
	result = [aDirectoryChooser runModalForDirectory:nil
                    file:nil types:nil];
	if (result == NSOKButton) {
		// add a new menu item and select it
		selectedFile = [aDirectoryChooser filename];
		[directorySelect insertItemWithTitle:selectedFile atIndex:1];
		[directorySelect selectItemAtIndex:1];
		curMenuItem = [directorySelect itemAtIndex:1];
		[curMenuItem setTarget:self];
		[curMenuItem setAction: @selector(directorySelected:)];
		selectedDirectory = 1;
	}
	else{
		[directorySelect selectItemAtIndex:selectedDirectory];
	}
}
- (IBAction)directorySelected:(id)sender{
	selectedDirectory = [directorySelect indexOfItem:sender];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
	NSLog(@"Application finished launching");
	NSString *message = [NSString stringWithFormat:@"selected index: %d",
		[directorySelect indexOfSelectedItem]]; 
	NSLog(message);
	selectedDirectory = [directorySelect indexOfSelectedItem];
}
-(void)dealloc{
	if(aHiFind != nil){
		[aHiFind release];
		aHiFind = nil;
	
	}
	
	[super dealloc];
}


@end
