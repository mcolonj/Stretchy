//
//  ViewController.m
//  Stretchy
//
//  Created by Michael Colon on 1/23/13.
//  Copyright (c) 2013 Michael Colon. All rights reserved.
//

#import "ViewController.h"
#import "StretchyGlyph.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) loadView {
  
  StretchyGlyph *thingy = [[StretchyGlyph alloc] init];
  
  self.view = thingy;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
