//
//  MainTextField.m
//  FontFile2FontName
//
//  Created by takashi nakamura on 10/12/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainTextField.h"
#import "FontFile2FontNameAppDelegate.h"


@implementation MainTextField

@synthesize enableExtList;

- (void)fontFile2fontName:(NSString *)fontFile {
	[self setStringValue:fontFile];
	[[NSApp delegate] dropFontFile];
}

/*
 以下、ドラッグ＆ドロップの処理
 
 【参照サイト】
 Mac Dev Center: Drag and Drop Programming Topics for Cocoa: Receiving Drag Operations
 http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/DragandDrop/Tasks/acceptingdrags.html
 
 */
- (void)awakeFromNib {
    // ドラッグを受け付けるタイプの指定。 NSFilenamesPboardType の場合はFinderからのドラッグなど
    [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
	self.enableExtList = [NSArray arrayWithObjects:@"otf", @"ttf", @"ttc", nil];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        if (sourceDragMask & NSDragOperationCopy) {
            NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
			for (NSString *enableExt in enableExtList) {
				if ([[[[files objectAtIndex:0] pathExtension] lowercaseString] isEqualToString:enableExt]) {
					return NSDragOperationCopy;
				}
			}
        }
    }
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        if (sourceDragMask & NSDragOperationCopy) {
            NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
			for (NSString *enableExt in enableExtList) {
				if ([[[[files objectAtIndex:0] pathExtension] lowercaseString] isEqualToString:enableExt]) {
					return YES;
				}
			}
        }
    }
    return NO;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        if (sourceDragMask & NSDragOperationCopy) {
			for (NSString *enableExt in enableExtList) {
				if ([[[[files objectAtIndex:0] pathExtension] lowercaseString] isEqualToString:enableExt]) {
					[self fontFile2fontName:[files objectAtIndex:0]];
				}
			}
        }
    }
}

@end
