//
//  StretchyGlyph.h
//  StretchyGlyph
//
//  Created by Michael Colon on 1/23/13.
//  Copyright (c) 2013 Michael Colon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StretchyGlyph : UIView {
  
  CGPoint point, firstTouchPoint_, currentTouch_; // touchPoint - currentTouchPoint
  CGPoint distance_;
  CGPoint previousDistance_;
  BOOL stop_;
}

-(void)stretch: (CGPoint) pos;


@end
