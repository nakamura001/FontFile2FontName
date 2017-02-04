//
//  FontFile2FontNameAppDelegate.h
//  FontFile2FontName
//
//  Created by takashi nakamura on 10/12/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainTextField.h"

@interface FontFile2FontNameAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet MainTextField *fontFileTextField;
	IBOutlet NSTextField *fontNameTextField;
}
- (void)dropFontFile;

@property (assign) IBOutlet NSWindow *window;

@end
