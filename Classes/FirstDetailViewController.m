
/*
     File: FirstDetailViewController.m
 Abstract: A simple view controller that adopts the SubstitutableDetailViewController protocol defined by RootViewController.
 It's responsible for adding and removing the popover button in response to rotation. This view controller uses a toolbar.
 
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "FirstDetailViewController.h"


@implementation FirstDetailViewController

@synthesize detailItem, imageView, rootViewController, navigationBar, tapOrMove;

#pragma mark -
#pragma mark View lifecycle

int areaTypeII = -1;
int ISurrender = 0;
CGFloat originalDistance;
float ratioxII, ratioyII, originalwidthII, originalheightII;

-(void) onTimer {
    
	[UIView beginAnimations:@"my_own_animation" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	ISurrender-=20;
    imageView.center = CGPointMake(ISurrender,
                                   imageView.center.y);
    
    navigationBar.center = CGPointMake(navigationBar.center.x - 20,
                                           navigationBar.center.y);
    
	[UIView commitAnimations];
    
    if (navigationBar.center.x <= self.view.bounds.size.width / 2 )   
    {
        imageView.center = CGPointMake(imageView.bounds.size.width/2 ,
                                       imageView.center.y);
        navigationBar.center = CGPointMake(navigationBar.bounds.size.width/2 ,
                                           navigationBar.center.y);
        [timer invalidate];
    }
	
}

-(void) onTimer2 {
    
    [timer invalidate];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(tapOrMove == false && areaTypeII > 0)
    {
        switch (areaTypeII) {
            case 1:
                [rootViewController Ray:2 whichRoom:@"【客迎．傳情】"];
                break;
            case 2:
                [rootViewController Ray:2 whichRoom:@"【花漾．綠動】"];
                break;
            case 3:
                [rootViewController Ray:2 whichRoom:@"【家客．融蘊】"];
                break;
        }
	}
    
}

-(CGFloat) distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
	
    float lengthX = fromPoint.x - toPoint.x;
    float lengthY = fromPoint.y - toPoint.y;
    return sqrt((lengthX * lengthX) + (lengthY * lengthY));	
}

//---fired when the user finger(s) touches the screen---
-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
    tapOrMove = true;
    //---compare the number of touches on the screen---
    switch ([allTouches count])
    {
			//---single touch---
        case 1: {
            //---get info of the touch---
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			CGPoint touchPT = [touch locationInView:[self view]];
            //---compare the touches---
            switch ([touch tapCount])
            {
					//---single tap---
                case 1: {
                    tapOrMove = false;

                    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                             target:self
                                                           selector:@selector(onTimer2)
                                                           userInfo:nil
                                                            repeats:NO];
                    if(touchPT.x >= 10 * ratioxII + imageView.frame.origin.x && touchPT.y >= 130 * ratioyII + imageView.frame.origin.y && touchPT.x <= 200 * ratioxII + imageView.frame.origin.x && touchPT.y <= 260 * ratioyII + imageView.frame.origin.y)
                        areaTypeII = 1;
                    else if(touchPT.x >= 245 * ratioxII + imageView.frame.origin.x && touchPT.y >= 25 * ratioyII + imageView.frame.origin.y && touchPT.x <= 460 * ratioxII + imageView.frame.origin.x && touchPT.y <= 140 * ratioyII + imageView.frame.origin.y)
                        areaTypeII = 2;
                    else if(touchPT.x >= 380 * ratioxII + imageView.frame.origin.x && touchPT.y >= 350 * ratioyII + imageView.frame.origin.y && touchPT.x <= 660 * ratioxII + imageView.frame.origin.x && touchPT.y <= 470 * ratioyII + imageView.frame.origin.y)
                        areaTypeII = 3;
                    else
                        areaTypeII = 0;
                } break;
					
					//---double tap---
                case 2: {
                    imageView.contentMode = UIViewContentModeCenter;
                } break;
            }
        }  break;
			
            //---double-touch---
        case 2: {
            //---get info of first touch---
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			
            //---get info of second touch---
            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
            //---get the points touched---
            CGPoint touch1PT = [touch1 locationInView:[self view]];
            CGPoint touch2PT = [touch2 locationInView:[self view]];
			
            NSLog(@"Touch1: %.0f, %.0f", touch1PT.x, touch1PT.y);
            NSLog(@"Touch2: %.0f, %.0f", touch2PT.x, touch2PT.y);
			
			//---record the distance made by the two touches---
			originalDistance  = [self distanceBetweenTwoPoints:touch1PT 
													   toPoint:touch2PT];
        } break;
    }
}

//---fired when the user moved his finger(s) on the screen---
-(void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
	
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
	tapOrMove = true;
    //---compare the number of touches on the screen---
    switch ([allTouches count])
    {
			//---single touch---
        case 1: {
            //---get info of the touch---
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			
            //---check to see if the image is being touched---
            CGPoint touchPoint = [touch locationInView:[self view]];
			
            if (touchPoint.x > imageView.frame.origin.x &&
                touchPoint.x < imageView.frame.origin.x +
				imageView.frame.size.width &&
                touchPoint.y > imageView.frame.origin.y &&
                touchPoint.y <imageView.frame.origin.y +
				imageView.frame.size.height) {
                [imageView setCenter:touchPoint];
            }
        }  break;
			
			//---double-touch---
        case 2: {
            //---get info of first touch---
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			
            //---get info of second touch---
            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
            //---get the points touched---
            CGPoint touch1PT = [touch1 locationInView:[self view]];
            CGPoint touch2PT = [touch2 locationInView:[self view]];
			
            NSLog(@"Touch1: %.0f, %.0f", touch1PT.x, touch1PT.y);
            NSLog(@"Touch2: %.0f, %.0f", touch2PT.x, touch2PT.y);
			
            CGFloat currentDistance = [self distanceBetweenTwoPoints: touch1PT
															 toPoint: touch2PT];
			
            //---zoom in---
            if (currentDistance > originalDistance)
            {
                imageView.frame = CGRectMake(imageView.frame.origin.x - 4,
                                             imageView.frame.origin.y - 4,
                                             imageView.frame.size.width + 8,
                                             imageView.frame.size.height + 8);
            }
            else {
                //---zoom out---
                imageView.frame = CGRectMake(imageView.frame.origin.x + 4,
                                             imageView.frame.origin.y + 4,
                                             imageView.frame.size.width - 8,
                                             imageView.frame.size.height - 8);
            }
            originalDistance = currentDistance;
            ratioxII = imageView.bounds.size.width / originalwidthII;
            ratioyII = imageView.bounds.size.height / originalheightII;
        } break;
    }
}

- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
        
        // Update the view.
        if ([newDetailItem isEqualToString:@"Training Day"])
        {
            navigationBar.topItem.title = @"【客迎．傳情】";
        }
        else if ([newDetailItem isEqualToString:@"HomePage-001"])
        {
            navigationBar.topItem.title = @"【首頁】";
        }
        else if ([newDetailItem isEqualToString:@"Remember the Titans"])
        {
            navigationBar.topItem.title = @"【花漾．綠動】";
        }
        else if ([newDetailItem isEqualToString:@"John Q"])
        {
            navigationBar.topItem.title = @"【家客．融蘊】";
        }
        else
            navigationBar.topItem.title = [detailItem description];
		
        NSString *imageName	= [NSString stringWithFormat:@"%@.jpg",[detailItem description] ];
		imageView.image = [UIImage imageNamed:imageName];
        
        [self doAnimation];
    }

    if (rootViewController.popoverController != nil) {
        [rootViewController.popoverController dismissPopoverAnimated:YES];
    }

}


- (void)viewDidUnload {
	[super viewDidUnload];
	//[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    originalwidthII = imageView.image.size.width;
    originalheightII = imageView.image.size.height;
    ratioxII = 1.0;
    ratioyII = 1.0;
    // Do any additional setup after loading the view from its nib.
}

- (void)doAnimation {
    if([navigationBar.topItem.title isEqualToString:@"【首頁】"])
    {
        tapOrMove = false;
    
        //imageView.center = CGPointMake( self.view.bounds.size.width + imageView.image.size.width/2 ,navigationBar.bounds.size.height + imageView.frame.size.height/2);
        [imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
        imageView.center = CGPointMake(self.view.bounds.size.width + imageView.bounds.size.width/2 , self.view.bounds.size.height/2);
        ISurrender = imageView.center.x;
        
        navigationBar.center = CGPointMake(self.view.bounds.size.width + navigationBar.bounds.size.width/2, navigationBar.center.y);
    
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
											 target:self
										   selector:@selector(onTimer)
										   userInfo:nil
											repeats:YES];
    }
    else
        [rootViewController Ray:2 whichRoom:navigationBar.topItem.title];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [navigationBar release];
    [detailItem release];
    [imageView release];
    [super dealloc];
}	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Add the popover button to the left navigation item.
    [navigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Remove the popover button.
    [navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
}

@end
