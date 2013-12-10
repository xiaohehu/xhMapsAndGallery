//
//  mapViewController.m
//  xhMapsAndGallery
//
//  Created by Xiaohe Hu on 11/21/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "mapViewController.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface mapViewController ()

@end

@implementation mapViewController
@synthesize mode = _mode;
@synthesize foldStyle = _foldStyle;
@synthesize flipStyle = _flipStyle;
@synthesize uiv_mapContainer;
@synthesize mapIndex;
@synthesize directionSegment;
@synthesize pageStepper;
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initVC];
    [self.modeSegment setSelectedSegmentIndex:(int)[self mode]];
	[self.uiv_mapContainer insertSubview:[self getLabelForIndex:mapIndex] atIndex:0];
    pageStepper.value = mapIndex;
}
-(void)initVC
{
    //    uiiv_maps = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Acccess_noLabels.jpg"]];
    //    [uiv_mapContainer addSubview:uiiv_maps];
    _mode = MPTransitionModeFold;
    //	_foldStyle = MPFoldStyleCubic;
	_flipStyle = MPFlipStyleDefault;
    _foldStyle = MPFoldStyleDefault;
    _foldStyle = MPFoldStyleUnfold;
    
}
#pragma mark - Properties
-(void)setMapIndex:(int)index
{
    mapIndex = index;
}
- (NSUInteger)style
{
	switch ([self mode]) {
		case MPTransitionModeFold:
			return [self foldStyle];
			
		case MPTransitionModeFlip:
			return [self flipStyle];
	}
}

- (void)setStyle:(NSUInteger)style
{
	switch ([self mode]) {
		case MPTransitionModeFold:
			[self setFoldStyle:style];
			break;
			
		case MPTransitionModeFlip:
			[self setFlipStyle:style];
			break;
	}
}

- (BOOL)isFold
{
	return [self mode] == MPTransitionModeFold;
}

#pragma mark- Hnadle Controllers

- (IBAction)modeValueChanged:(id)sender {
    [self setMode:[sender selectedSegmentIndex]];
	[self updateClipsToBounds];
    switch ([sender selectedSegmentIndex]) {
        case 0:
            directionSegment.hidden = NO;
            break;
        case 1:
            directionSegment.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (IBAction)stepperValueChanged:(id)sender {
    UIStepper *stepper = sender;
	[stepper setUserInteractionEnabled:NO];
    
	UIView *previousView = [[uiv_mapContainer subviews] objectAtIndex:0];
//	UIView *nextView = [self getLabelForIndex:(stepper.value + mapIndex)];
    UIView *nextView = [self getLabelForIndex:stepper.value];
	BOOL forwards = nextView.tag > previousView.tag;
	// handle wrap around
	if (nextView.tag == stepper.maximumValue && previousView.tag == stepper.minimumValue)
		forwards = NO;
	else if (nextView.tag == stepper.minimumValue && previousView.tag == stepper.maximumValue)
		forwards = YES;
	
    
	// execute the transition
	if ([self isFold])
	{
		[MPFoldTransition transitionFromView:previousView
									  toView:nextView
									duration:[MPFoldTransition defaultDuration]
									   style:forwards? [self foldStyle]	: MPFoldStyleFlipFoldBit([self foldStyle])
							transitionAction:MPTransitionActionAddRemove
								  completion:^(BOOL finished) {
									  [stepper setUserInteractionEnabled:YES];
								  }
		 ];
	}
	else
	{
		[MPFlipTransition transitionFromView:previousView
									  toView:nextView
									duration:[MPTransition defaultDuration]
									   style:forwards? [self flipStyle]	: MPFlipStyleFlipDirectionBit([self flipStyle])
							transitionAction:MPTransitionActionAddRemove
								  completion:^(BOOL finished) {
									  [stepper setUserInteractionEnabled:YES];
								  }
		 ];
	}
}

- (IBAction)directionChanged:(id)sender {
    switch (directionSegment.selectedSegmentIndex) {
        case 0:
        {
            //            _foldStyle = MPFoldStyleDefault;
            _foldStyle = MPFoldStyleUnfold;
            //            [collectionView reloadData];
            break;
        }
        case 1:
        {
            _foldStyle = (MPFoldStyleHorizontal | MPFoldStyleUnfold);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Instance methods

- (UIView *)getLabelForIndex:(NSUInteger)index
{
	UIView *container = [[UIView alloc] initWithFrame:uiv_mapContainer.bounds];
	container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[container setBackgroundColor:[UIColor whiteColor]];
    
    //	UILabel *label = [[UILabel alloc] initWithFrame:CGRectInset(container.bounds, 10, 10)];
    //	label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //	[label setFont:[UIFont boldSystemFontOfSize:84]];
    //	[label setTextAlignment:NSTextAlignmentCenter];
    //	[label setTextColor:[UIColor lightTextColor]];
    //	label.text = [NSString stringWithFormat:@"%d", index + 1];
    UIImageView *uiiv_tmpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
	
	switch (index % 3) {
		case 0:
            //            uiiv_mpas = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Acccess_noLabels.jpg"]];
            [uiiv_tmpImgView setImage:[UIImage imageNamed:@"Acccess_noLabels.jpg"]];
			break;
			
		case 1:
            //            uiiv_mpas = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"POI_noLabels.jpg"]];
            [uiiv_tmpImgView setImage:[UIImage imageNamed:@"POI_noLabels.jpg"]];
            
			break;
			
		case 2:
            //            uiiv_mpas = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Leasing_Plan.jpg"]];
            [uiiv_tmpImgView setImage:[UIImage imageNamed:@"Leasing_Plan.jpg"]];
            
			break;
			
		default:
			break;
	}
	NSLog(@"asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasfasfdasdf");
    //    [uiiv_mpas setBackgroundColor:[UIColor blueColor]];
    //    uiiv_mpas.alpha = 0.5;
	[container addSubview:uiiv_tmpImgView];
	container.tag = index;
    [container setBackgroundColor:[UIColor blackColor]];
    //	[container.layer setBorderColor:[[UIColor colorWithWhite:0.85 alpha:1] CGColor]];
    //	[container.layer setBorderWidth:2];
	
	return container;
}

- (void)updateClipsToBounds
{
	// We want clipsToBounds == YES on the central contentView when fold style mode bit is not cubic
	// Otherwise you see the top & bottom panels sliding out and looks weird
	[uiv_mapContainer setClipsToBounds:[self isFold] && (([self foldStyle] & MPFoldStyleCubic) != MPFoldStyleCubic)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
