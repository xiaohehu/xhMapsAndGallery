//
//  ViewController.h
//  xhMapsAndGallery
//
//  Created by Xiaohe Hu on 11/21/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViewController.h"

@interface ViewController : UIViewController{
    mapViewController *mapVC;
//    embAlbumViewController *albumVC;
}

@property (nonatomic, strong) UIViewController *controller;

@property (weak, nonatomic) IBOutlet UIButton *uib_map1;
@property (weak, nonatomic) IBOutlet UIButton *uib_map2;
@property (weak, nonatomic) IBOutlet UIButton *uib_map3;
@property (weak, nonatomic) IBOutlet UIButton *uib_gallery;
@property (weak, nonatomic) IBOutlet UIButton *uib_back;

@property (nonatomic, strong) mapViewController *mapVC;
//@property (nonatomic, strong) embAlbumViewController *albumVC;

- (IBAction)tapMap1:(id)sender;
- (IBAction)tapMap2:(id)sender;
- (IBAction)tapMap3:(id)sender;
- (IBAction)tapGallery:(id)sender;
- (IBAction)tapBackBtn:(id)sender;


@end
