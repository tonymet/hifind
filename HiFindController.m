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

- (IBAction)chooseDirectory:(id)sender{
	int result = nil;
	NSString *selectedFile;
	result = [aDirectoryChooser runModalForDirectory:nil
                    file:nil types:nil];
	if (result == NSOKButton) {
		// add a new menu item and select it
		selectedFile = [aDirectoryChooser filename];
		[directorySelect insertItemWithTitle:selectedFile atIndex:1];
		[directorySelect selectItemAtIndex:1];
	}
}
-(void)dealloc{
	if(aHiFind != nil){
		[aHiFind release];
		aHiFind = nil;
	
	}
	
	[super dealloc];
}


@end
