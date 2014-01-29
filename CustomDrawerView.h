//
//  CustomDrawerView.h
//
//  Created by Kireto on 11/18/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDrawerView : UIView

@property(nonatomic,strong)UIViewController* bottomController;
@property(nonatomic,strong)UIViewController* firstDrawerController;
@property(nonatomic,strong)UIViewController* secondDrawerController;
@property(nonatomic,strong)UIView *firstDrawerView;
@property(nonatomic,strong)UIView *secondDrawerView;
@property(nonatomic,assign)CGFloat touchOffset;
@property(nonatomic,assign)CGFloat topOffset;
@property(nonatomic,assign)CGFloat firstDrawerWidth;
@property(nonatomic,assign)CGFloat secondDrawerWidth;

- (void)setupFistrDrawerController:(UIViewController*)drawerController withWidth:(CGFloat)drawerWidth;
- (void)setupSecondDrawerController:(UIViewController*)drawerController withWidth:(CGFloat)drawerWidth;

- (void)hideFirstDrawer;
- (void)hideSecondDrawer;

- (void)resetDrawerFrames;

@end
