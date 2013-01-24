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
#define CURVE_PERCENT 0.7f
#define TOP_LIMIT .10f
#define SQUEEZE_LIMIT 0.4f
#define STRETCHY_WIDTH 100.0f

- (void)drawRect:(CGRect)rect
{
  // draw stretchy
  
  // limit stretch if stop flag is true. Also limits retraction
  if ( ! stop_ )
    previousDistance_ = distance_;
  else
    distance_ = previousDistance_;
  
  // create variables.
  UIBezierPath *path = [UIBezierPath bezierPath];
  float squeezeValue = distance_.y * 0.3f;
  float topSqueeze = squeezeValue;
  float bottomSqueeze = 0.0f;
  
  
  // set top limit
  if ( topSqueeze > (squeezeValue * TOP_LIMIT) )
    topSqueeze = squeezeValue * TOP_LIMIT;
  
  // limit squeeze value
  if ( squeezeValue > (squeezeValue * SQUEEZE_LIMIT) )
    squeezeValue = (squeezeValue * SQUEEZE_LIMIT);

  // makes nice round bottom lol
  float bottomCurve = squeezeValue + topSqueeze;
  
  // determine curve from width
  float curve = STRETCHY_WIDTH * CURVE_PERCENT;
  
  //get squeeze value
  bottomSqueeze = squeezeValue;
  
  // limit bottom squeeze. When bottom squeeze causes bottom arc to touch stop stretching.
  if ( bottomSqueeze >= STRETCHY_WIDTH * 0.45f ) {
    bottomSqueeze = STRETCHY_WIDTH * 0.45f;
    stop_ = YES;
  }
  
  // left point
  [path moveToPoint:CGPointMake(point.x + topSqueeze, point.y)];
  
  // right point curved
  [path addCurveToPoint:CGPointMake(point.x + STRETCHY_WIDTH - topSqueeze, point.y)
          controlPoint1:CGPointMake(point.x , point.y - curve )
          controlPoint2:CGPointMake(point.x + STRETCHY_WIDTH, point.y - curve )];
  
  // right point
  [path addLineToPoint:CGPointMake(point.x + STRETCHY_WIDTH - bottomSqueeze, point.y + distance_.y)];
  
  // left point curved
  [path addCurveToPoint:CGPointMake(point.x + bottomSqueeze, point.y + distance_.y)
          controlPoint1:CGPointMake(point.x + STRETCHY_WIDTH - bottomSqueeze, point.y + distance_.y + curve - bottomCurve)
          controlPoint2:CGPointMake(point.x + bottomSqueeze, point.y + distance_.y + curve - bottomCurve)];
  
  
  [path closePath];
  [path fill];
  
}

-(void) stretch:(CGPoint)pos {
  
  // set stretch distance
  distance_ = pos;
  [self setNeedsDisplay];
  
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  // get first touch point to determine stretch distance
  UITouch *touch = [touches anyObject];
  firstTouchPoint_ = [touch locationInView:self];
  
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  //determine stretch distance.
  UITouch *touch = [touches anyObject];
  currentTouch_ = [touch locationInView:self];
  
  [self stretch:CGPointMake(currentTouch_.x - firstTouchPoint_.x, currentTouch_.y - firstTouchPoint_.y)];
  
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
  
  // reset touch points for next touch event
  currentTouch_ = CGPointZero;
  firstTouchPoint_ = CGPointZero;
  
  // resume to retract stretch
  stop_ = NO;
  [self stretch:CGPointMake(currentTouch_.x - firstTouchPoint_.x, currentTouch_.y - firstTouchPoint_.y)];
}


@end
