//
//  ViewController.m
//  xhMapsAndGallery
//
//  Created by Xiaohe Hu on 11/21/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"
#import "embAlbumViewController.h"
@interface ViewController ()
@property embAlbumViewController *albumController;
@end

@implementation ViewController
@synthesize mapVC;
@synthesize uib_back,uib_gallery,uib_map1,uib_map2,uib_map3;

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(hideBackBtn:)
												 name:@"tapOnCell"
											   object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(unhideBackBtn:)
												 name:@"backToGallery"
											   object:nil];
    
}

-(void)hideBackBtn:(NSNotification *)pNotification
{
    uib_back.alpha = 0.0;
}

-(void)unhideBackBtn:(NSNotification *)pNotification
{
    uib_back.alpha = 1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapMap1:(id)sender {
    mapVC = [[mapViewController alloc] initWithNibName:@"mapViewController" bundle:nil];
    [mapVC setMapIndex:0];
    _controller = mapVC;
    [self performSelector:@selector(vcTransition) withObject:nil afterDelay:0.1];
}

- (IBAction)tapMap2:(id)sender {
    mapVC = [[mapViewController alloc] initWithNibName:@"mapViewController" bundle:nil];
    [mapVC setMapIndex:1];
    _controller = mapVC;
    [self performSelector:@selector(vcTransition) withObject:nil afterDelay:0.1];;
}

- (IBAction)tapMap3:(id)sender {
    mapVC = [[mapViewController alloc] initWithNibName:@"mapViewController" bundle:nil];
    [mapVC setMapIndex:2];
    _controller = mapVC;
    [self performSelector:@selector(vcTransition) withObject:nil afterDelay:0.1];
}

- (IBAction)tapGallery:(id)sender {
    _albumController = [[embAlbumViewController alloc] initWithNibName:@"embAlbumViewController" bundle:nil];
    _albumController.plistName = @"thumbnailData";
    
    _albumController.typeOfAlbum = @"photos";
    _controller = _albumController;
    [self performSelector:@selector(vcTransition) withObject:nil afterDelay:0.1];
}

- (IBAction)tapBackBtn:(id)sender {
    CATransition *transitionAnimation = [CATransition animation];
	[transitionAnimation setDuration:0.33];
	[transitionAnimation setType:kCATransitionFade];
	[transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	[self.view.layer addAnimation:transitionAnimation forKey:kCATransitionFade];
    
    for (UIViewController *vc in self.childViewControllers) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

-(void)vcTransition
{
    CATransition *transitionAnimation = [CATransition animation];
	[transitionAnimation setDuration:0.33];
	[transitionAnimation setType:kCATransitionFade];
	[transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    transitionAnimation.delegate = self;
	[self.view.layer addAnimation:transitionAnimation forKey:kCATransitionFade];
    
    [self addChildViewController:_controller];
    [self.view insertSubview:_controller.view belowSubview:uib_back];
    [_controller didMoveToParentViewController:self];
}
@end
