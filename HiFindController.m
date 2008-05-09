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
	// call init to clear the data source
	[aHFDataSource init];
	[aHFDataSource appendFromArray:
		[aHiFind allRecords:
			[aHiFind 
				grepFilesMatchingPattern:[filePatternField stringValue] 
				inDirectory:[directoryNameField stringValue] 
				withRegex:[regexPatternField stringValue]
			]
		]
	];
	[resultsTableView reloadData];
}
- (IBAction)updateDSFromFile:(id)sender{
	// call init to clear the data source
	[aHFDataSource release];
	[aHFDataSource init];
	[aHFDataSource appendFromArray:
		[aHiFind allRecords:
			[aHiFind readFromFile:[directoryNameField stringValue]]
		]
	];
	[resultsTableView reloadData];
}

- (IBAction)initButton:(id)sender{

}

- (IBAction)chooseDirectory:(id)sender{
	int result = nil;
	NSString *selectedFile;
	result = [aDirectoryChooser runModalForDirectory:nil
                    file:nil types:nil];
	 if (result == NSOKButton) {
		selectedFile = [aDirectoryChooser filename];
		[directoryNameField setStringValue:selectedFile];
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
