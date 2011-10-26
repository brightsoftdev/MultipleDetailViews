
/*
     File: SecondDetailViewController.m
 Abstract: A simple view controller that adopts the SubstitutableDetailViewController protocol defined by RootViewController.
 It's responsible for adding and removing the popover button in response to rotation. This view controller uses a navigation bar.
 
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

#import "SecondDetailViewController.h"

@implementation SecondDetailViewController

@synthesize rootViewController, navigationBar, tapOrMove, imageView, movieTitles, years, tableView, label, titleName, thirdName, scrollView;

#pragma mark -
#pragma mark View lifecycle
int cellIndex = 0;
int headcnt = 0;
UIInterfaceOrientation whatNow;

-(void) onTimer {
    
	[UIView beginAnimations:@"my_own_animation" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
    /*
     imageView.center = CGPointMake(imageView.center.x + 20,
                                   imageView.center.y);
    
    tableView.center = CGPointMake(tableView.center.x + 5,
                                   tableView.center.y);
    */
	navigationBar.center = CGPointMake(navigationBar.center.x + 20,
                                       navigationBar.center.y);
    scrollView.center = CGPointMake(scrollView.center.x + 20,
                                       scrollView.center.y);

    
    [UIView commitAnimations];
    
    if (scrollView.center.x >= self.view.bounds.size.width / 2 )   
    {
        /*
        imageView.center = CGPointMake(imageView.bounds.size.width/2 ,
                                       imageView.center.y);
        tableView.center = CGPointMake(tableView.bounds.size.width/2 ,
                                       tableView.center.y);
        */
        navigationBar.center = CGPointMake(navigationBar.bounds.size.width/2 ,
                                           navigationBar.center.y);
        scrollView.center = CGPointMake(scrollView.bounds.size.width/2, scrollView.center.y);
        [timer invalidate];
        
        label.contentOffset = CGPointMake(0, 0);

    }
	
    label.contentOffset = CGPointMake(0, 1);

}

-(void) onTimer2 {
    
    [timer invalidate];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(tapOrMove == false)
    {
        switch (rootViewController.oneOrTwo) {
            case 2:
                [rootViewController LoadThreeView:thirdName];
                break;
            case 3:
                rootViewController.thirdViewController.detailItem = thirdName;
                break;
            default:
                break;
        }
    }
    
}

- (void)doAnimation {
    tapOrMove = false;
    /*
    imageView.center = CGPointMake( -imageView.image.size.width/2 ,
                                   14 + navigationBar.bounds.size.height + imageView.frame.size.height/2);
    [tableView setFrame:CGRectMake(0, 0, 200, 200)];
    tableView.center = CGPointMake( -tableView.bounds.size.width/2 ,
                                   imageView.frame.origin.y + imageView.frame.size.height + tableView.bounds.size.height/2 - 58);
    */
    navigationBar.center = CGPointMake( -navigationBar.bounds.size.width/2 ,
                                       navigationBar.center.y);
    scrollView.center = CGPointMake( -scrollView.bounds.size.width/2 ,
                                    scrollView.center.y);
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
											 target:self
										   selector:@selector(onTimer)
										   userInfo:nil
											repeats:YES];
}

-(void) viewDidUnload {
	[super viewDidUnload];
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.  
        if(rootViewController.oneOrTwo == 3)
        {
            [rootViewController Ray:2 whichRoom:titleName];
            [rootViewController.secondViewController doAnimation];
        }
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    //---path to the property list file---
    NSString *path;
    NSString *imageName;
    
    [super viewDidLoad];
    
    if ([titleName isEqualToString:@"【客迎．傳情】"])
    {
        imageName = @"Training Day.jpg";
        label.text = @"造型與構作:「手工彩色玻璃」與「傳統客家山歌」呈現的視覺、影像與音樂構成客家印象之迎賓長廊空間。\n空間裝置：藝術手工彩色玻璃迎賓\n聲響裝置：客家山歌等傳統歌謠之［空間性重組］"; 
        cellIndex = 1;
        path = [[NSBundle mainBundle] pathForResource:@"Movies" 
                                               ofType:@"plist"];
    }
    else if ([titleName isEqualToString:@"【花漾．綠動】"])
    {
        imageName = @"Remember the Titans.jpg";
        label.text = @"作品延伸建築的原意，利用多種三角玻璃面設計一組代表四季的抽象且具趣味性的翻摺裝置雕塑品。\n【花漾．綠動】利用自然風力微微轉動\n四件大型裝置雕塑品其玻璃經高溫夾膜製程\n作品材質與裝置為金屬結構、彩色夾膜玻璃(大型)、手工彩色玻璃(小型)、強化玻璃 、底盤旋轉機械裝置—防水無油軸承、投射燈及沉水揚水馬達"; 
        cellIndex = 2;
        path = [[NSBundle mainBundle] pathForResource:@"Theater" 
                                               ofType:@"plist"];
    }
    else if ([titleName isEqualToString:@"【家客．融蘊】"])
    {
        imageName = @"John Q.jpg";
        label.text = @"造型與構作:大型馬賽克圖像創作\n牡丹是客家傳統的文化圖騰，而油桐近年也成演變客家的主要象徵，兩種花在園區的大門前交融接觸，新與舊融合，象徵客家隨時進步的精神\n陶瓷馬賽克拼貼設置於前廣場階梯「垂直立面」\n利用階梯座位特性，觀者視角錯位時，作品呈現出水花波紋漣漪"; 
        cellIndex = 3;
        path = [[NSBundle mainBundle] pathForResource:@"Ticket" 
                                               ofType:@"plist"];
    }
    else
    {
        cellIndex = 0;
    }
    
    //---load the list into the dictionary---
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    //---save the dictionary object to the property---
    self.movieTitles = dic;
    [dic release];
    
    //---get all the keys in the dictionary object and sort them---
    NSArray *array = [[movieTitles allKeys] 
					  sortedArrayUsingSelector:@selector(compare:)];
    //---save the keys in the years property---
    self.years = array;	
    headcnt = [years count];
    int cellcnt = 0;
    for (int ii = 0; ii < headcnt; ii++) {
        NSArray *movieSection = [movieTitles objectForKey:[years objectAtIndex:ii]];
        //---return the number of movies for that year as the number of rows in that 
        // section ---
        cellcnt += [movieSection count];
    }
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    int theHeight = 0;
    int labelLen = 0;
    
    if(rootViewController.oneOrTwo == 3)
    {
        self.title = titleName;
        [navigationBar setHidden:TRUE];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:imageName];
        [imageView setFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.width * imageView.image.size.height / imageView.image.size.width)];
        theHeight = imageView.frame.size.height;
        
        switch (cellIndex) {
            case 1:
                labelLen = 20 * 7;
                [label setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 460, labelLen)];
                theHeight += labelLen;
                break;
            case 2:
                labelLen = 20 * 11;
                [label setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 460, labelLen)];
                theHeight += labelLen;
                break;
            case 3:
                labelLen = 20 * 11;
                [label setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 460, labelLen)];
                theHeight += labelLen;

                break;
        }
        labelLen = tableView.sectionHeaderHeight * headcnt + tableView.rowHeight * cellcnt;
        [tableView setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 460, labelLen ) ];   
        
        theHeight += labelLen; 
        
        scrollView.contentSize = CGSizeMake( (applicationFrame.size.width<=imageView.bounds.size.width?imageView.bounds.size.width:applicationFrame.size.width), (applicationFrame.size.height <= theHeight?theHeight:applicationFrame.size.height) );  
        
        [scrollView setFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        
    }
    else
    {
        navigationBar.topItem.title = titleName;      

        imageView.image = [UIImage imageNamed:imageName];
        
        [imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
        theHeight = imageView.image.size.height;
        
        switch (cellIndex) {
            case 1:
                labelLen = 20 * 5;
                [label setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 70, labelLen)];
                theHeight += labelLen;
                break;
            case 2:
                labelLen = 20 * 7;
                [label setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 70, labelLen)];
                theHeight += labelLen;
                break;
            case 3:
                labelLen = 20 * 7;
                [label setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 70, labelLen)];
                theHeight += labelLen;
                break;
        }
        labelLen = tableView.sectionHeaderHeight * headcnt + tableView.rowHeight * cellcnt;        
        [tableView setFrame:CGRectMake(0, theHeight, self.view.bounds.size.width - 70, labelLen ) ];
        theHeight += labelLen; 
        
        if(whatNow == UIInterfaceOrientationPortrait)
        {
            scrollView.contentSize = CGSizeMake( (applicationFrame.size.width<=imageView.bounds.size.width?imageView.bounds.size.width:applicationFrame.size.width), (applicationFrame.size.height <= theHeight?theHeight:applicationFrame.size.height) );  
        }
        else
        {
            scrollView.contentSize = CGSizeMake( (applicationFrame.size.width<=imageView.bounds.size.width?imageView.bounds.size.width:applicationFrame.size.width), (applicationFrame.size.height <= theHeight?theHeight:applicationFrame.size.height+300) );  
        }

    }
    
    if(rootViewController.rootPopoverButtonItem != nil)
    {
        switch (rootViewController.oneOrTwo) {
            case 3:
                rootViewController.rootPopoverButtonItem.title = titleName;
                break;
            default:
                rootViewController.rootPopoverButtonItem.title = @"客家文化會館";
                break;
        }
        
    }
    // Do any additional setup after loading the view from its nib.
    fileController = [FilesHandlingViewController new];
    
}

#pragma mark -
#pragma mark Managing the popover
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    //return 1;
    return headcnt;    
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return 10;
    //---check the current year based on the section index---
    NSString *year = [years objectAtIndex:section];
    //---returns the movies in that year as an array---
    NSArray *movieSection = [movieTitles objectForKey:year];
    //---return the number of movies for that year as the number of rows in that 
    // section ---
    return [movieSection count];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [navigationBar release];
    [imageView release];
    [movieTitles release];
    [years release];
    [scrollView release];
    [label release];
    [fileController release];
    [super dealloc];
}	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    whatNow = interfaceOrientation;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
	
    //---get the year---
    NSString *year = [years objectAtIndex:[indexPath section]];
    //---get the list of movies for that year---
    NSArray *movieSection = [movieTitles objectForKey:year];
    //---get the particular movie based on that row---
    cell.textLabel.text = [movieSection objectAtIndex:[indexPath row]]; 
	
    UIImage *image = [UIImage imageNamed:@"apple.jpeg"];
    cell.imageView.image = image;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //---get the year as the section header---	
	NSString *year = [years objectAtIndex:section];
	return year;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
    //detailViewController.detailItem = [NSString stringWithFormat:@"Row %d", indexPath.row];
    tapOrMove = false;
    NSString *year = [years objectAtIndex:[indexPath section]];
    //---get the list of movies for that year---
    NSArray *movieSection = [movieTitles objectForKey:year];
    //---get the particular movie based on that row---
    thirdName = [movieSection objectAtIndex:[indexPath row]];
    int why = [indexPath row];
    why = why;
    if(cellIndex > 0)
    {
        [fileController RayWTF:[NSString stringWithFormat:@"%d_%d.txt", cellIndex, [indexPath row]+1] withoneimg:[NSString stringWithFormat:@"%d_%d.png", cellIndex, ([indexPath row]+1) ]];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(onTimer2)
                                           userInfo:nil
                                            repeats:NO];

}

@end
