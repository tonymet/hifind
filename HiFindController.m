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
	return self;
}

- (IBAction)search:(id)sender{
	[resultsView setString:
	[aHiFind fileToString:
		[aHiFind 
			grepFilesMatchingPattern:[filePatternField stringValue] 
			inDirectory:[directoryNameField stringValue] 
			withRegex:[regexPatternField stringValue]
		]
	]
	];
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


@end
