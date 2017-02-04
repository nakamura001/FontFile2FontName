//
//  FontFile2FontNameAppDelegate.m
//  FontFile2FontName
//
//  Created by takashi nakamura on 10/12/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FontFile2FontNameAppDelegate.h"

@implementation FontFile2FontNameAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (void)dropFontFile {
	//
	// 参照サイト
	// How do I embed a font in an app? | Cocoabuilder
	// http://www.cocoabuilder.com/archive/cocoa/203330-how-do-embed-font-in-an-app.html
	//
	NSString *fontFile = [fontFileTextField stringValue];
	NSData *fontData = [NSData dataWithContentsOfFile:fontFile];
	
	ATSFontContainerRef container = 0;
	OSStatus err = ATSFontActivateFromMemory([fontData bytes], [fontData length],
											 kATSFontContextLocal,
											 kATSFontFormatUnspecified,
											 NULL,
											 kATSOptionFlagsDefault,
											 &container );
	NSLog(@"%d", container);
	if( err != noErr )
		NSLog(@"failed to load font into memory");
	
	ATSFontRef fontRefs[100];
	ItemCount  fontCount;
	err = ATSFontFindFromContainer(
								   container,
								   kATSOptionFlagsDefault,
								   100,
								   fontRefs,
								   &fontCount );
	
	NSString *fontName;
	if( err != noErr || fontCount < 1 ){
		NSLog(@"font could not be loaded.");
	} else {
		err = ATSFontGetPostScriptName(
									   fontRefs[0],
									   kATSOptionFlagsDefault,
									   (CFStringRef*)( &fontName ) );
		
		NSLog(@"font %@ loaded", fontName);
	}
	[fontNameTextField setStringValue:fontName];
}

@end
