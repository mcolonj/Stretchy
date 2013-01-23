//
//  Thingy.m
//  Stretchy
//
//  Created by Michael Colon on 1/23/13.
//  Copyright (c) 2013 Michael Colon. All rights reserved.
//

#import "StretchyGlyph.h"

@implementation StretchyGlyph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      self.backgroundColor = [UIColor whiteColor];
      point = CGPointMake(120,60);
    }
    return self;
}

#define ARC_CURVE 70.0f

- (void)drawRect:(CGRect)rect
{
    // Drawing code
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  float squeezeValue = distance_.y * 0.3f;
  float topSqueeze = squeezeValue;
  
  
  // set top limit
  if ( topSqueeze > 13 )
    topSqueeze = 13;
  
  // limit squeeze value
  if ( squeezeValue > 40 )
    squeezeValue = 40;
  
  // makes nice round bottom lol
  float bottomCurve = squeezeValue + topSqueeze;
  
  
  // left point
  [path moveToPoint:CGPointMake(point.x + topSqueeze, point.y)];
  
  // right point curved
  [path addCurveToPoint:CGPointMake(point.x + 100 - topSqueeze, point.y)
          controlPoint1:CGPointMake(point.x , point.y - ARC_CURVE)
          controlPoint2:CGPointMake(point.x + 100, point.y - ARC_CURVE)];
  
  // right point
  [path addLineToPoint:CGPointMake(point.x + 100 - squeezeValue, point.y + distance_.y)];
  
  // left point curved
  [path addCurveToPoint:CGPointMake(point.x + squeezeValue, point.y + distance_.y)
          controlPoint1:CGPointMake(point.x + 100 - squeezeValue, point.y + distance_.y + ARC_CURVE - bottomCurve)
          controlPoint2:CGPointMake(point.x + squeezeValue, point.y + distance_.y + ARC_CURVE - bottomCurve)];
  
  
  [path closePath];
  [path fill];
  
}

-(void) stretch:(CGPoint)pos {
  
  distance_ = pos;
  [self setNeedsDisplay];
  
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [touches anyObject];
  firstTouchPoint_ = [touch locationInView:self];
  
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [touches anyObject];
  currentTouch_ = [touch locationInView:self];
  
  [self stretch:CGPointMake(currentTouch_.x - firstTouchPoint_.x, currentTouch_.y - firstTouchPoint_.y)];
  
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
  currentTouch_ = CGPointZero;
  firstTouchPoint_ = CGPointZero;
  [self stretch:CGPointMake(currentTouch_.x - firstTouchPoint_.x, currentTouch_.y - firstTouchPoint_.y)];
}


@end
