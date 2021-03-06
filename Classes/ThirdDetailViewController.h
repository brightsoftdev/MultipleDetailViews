//
//  ThirdDetailViewController.h
//  MultipleDetailViews
//
//  Created by Chang Alf on 2011/6/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "FilesHandlingViewController.h"
#import "TapDetectingImageView.h"
#import <AVFoundation/AVFoundation.h>

@class RootViewController;

@interface ThirdDetailViewController : UIViewController <UIScrollViewDelegate, TapDetectingImageViewDelegate, AVAudioPlayerDelegate> {
    
    UINavigationBar *navigationBar;
    RootViewController *rootViewController;   
    NSTimer *timer, *timer3;
    BOOL tapOrMove;  
    //UITextView *lable;
    NSString *titleName;
    id detailItem;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
//@property (nonatomic, retain) IBOutlet UITextView *label;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (readwrite) BOOL tapOrMove;
@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end
