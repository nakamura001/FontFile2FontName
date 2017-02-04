//
//  MainTextField.h
//  FontFile2FontName
//
//  Created by takashi nakamura on 10/12/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MainTextField : NSTextField {
	NSArray *enableExtList;
}
@property (copy) NSArray *enableExtList;

@end
