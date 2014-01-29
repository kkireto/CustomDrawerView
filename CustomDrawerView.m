//
//  CustomDrawerView.m
//
//  Created by Kireto on 11/18/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "CustomDrawerView.h"

#define shadowOffset 9.0

@implementation CustomDrawerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _topOffset = 0.0;
        [self setupView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark - setup view
- (void)setupView {
    
    self.backgroundColor = [UIColor clearColor];
    
    UIImage *shadowImage = [[UIImage imageNamed:@"drawerShadow"]stretchableImageWithLeftCapWidth:30.0 topCapHeight:30.0];
    UIImageView *shadowBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    shadowBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [shadowBgView setImage:shadowImage];
    shadowBgView.backgroundColor = [UIColor clearColor];
    shadowBgView.userInteractionEnabled = YES;
    [self addSubview:shadowBgView];
}

- (UIView*)createDrawerViewWithWidth:(CGFloat)drawerWidth {
    
    CGRect drawerViewFrame = CGRectMake(_bottomController.view.frame.size.width, _topOffset - shadowOffset, drawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
    UIView *drawerView = [[UIView alloc] initWithFrame:drawerViewFrame];
    drawerView.backgroundColor = [UIColor clearColor];
    drawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_bottomController.view addSubview:drawerView];
    
    UIImage *shadowImage = [[UIImage imageNamed:@"drawerShadow"]stretchableImageWithLeftCapWidth:30.0 topCapHeight:30.0];
    UIImageView *shadowBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, drawerView.frame.size.width, drawerView.frame.size.height)];
    shadowBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [shadowBgView setImage:shadowImage];
    shadowBgView.backgroundColor = [UIColor clearColor];
    shadowBgView.userInteractionEnabled = YES;
    [drawerView addSubview:shadowBgView];
    
    return drawerView;
}

#pragma mark -
#pragma mark - public setup methods
- (void)setupFistrDrawerController:(UIViewController*)drawerController withWidth:(CGFloat)drawerWidth {
    
    if (_secondDrawerController) {
        [_secondDrawerController.view removeFromSuperview];
        _secondDrawerController = nil;
        _secondDrawerWidth = 0.0;
    }
    if (_secondDrawerView) {
        [_secondDrawerView removeFromSuperview];
        _secondDrawerView = nil;
    }
    if (_firstDrawerController) {
        [_firstDrawerController.view removeFromSuperview];
        _firstDrawerController = nil;
        _firstDrawerWidth = 0.0;
    }
    if (_firstDrawerView) {
        [_firstDrawerView removeFromSuperview];
        _firstDrawerView = nil;
    }
    _firstDrawerController = drawerController;
    _firstDrawerWidth = drawerWidth;
    
    _firstDrawerView = [self createDrawerViewWithWidth:_firstDrawerWidth];
    
    CGRect drawerFrame = CGRectMake(shadowOffset, shadowOffset, _firstDrawerView.frame.size.width - 2*shadowOffset, _firstDrawerView.frame.size.height - 2*shadowOffset);
    [_firstDrawerController.view setFrame:drawerFrame];
    _firstDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _firstDrawerController.view.layer.cornerRadius = 4.0;
    [_firstDrawerController.view.layer setMasksToBounds:YES];
    [_firstDrawerView addSubview:_firstDrawerController.view];
    [self shouldEnableUserInteraction:NO];
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         _firstDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - drawerWidth - shadowOffset, _topOffset - shadowOffset, drawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             _firstDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - drawerWidth - shadowOffset, _topOffset - shadowOffset, drawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                             _firstDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
                             
                             UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
                             [_firstDrawerView addGestureRecognizer:panGesture];
                             [self shouldEnableUserInteraction:YES];
                         }
                     }];
}

- (void)setupSecondDrawerController:(UIViewController*)drawerController withWidth:(CGFloat)drawerWidth {
    
    if (_secondDrawerController) {
        [_secondDrawerController.view removeFromSuperview];
        _secondDrawerController = nil;
        _secondDrawerWidth = 0.0;
    }
    if (_secondDrawerView) {
        [_secondDrawerView removeFromSuperview];
        _secondDrawerView = nil;
    }
    _secondDrawerController = drawerController;
    _secondDrawerWidth = drawerWidth;
    
    _secondDrawerView = [self createDrawerViewWithWidth:_secondDrawerWidth];
    
    CGRect drawerFrame = CGRectMake(shadowOffset, shadowOffset, _secondDrawerView.frame.size.width - 2*shadowOffset, _secondDrawerView.frame.size.height - 2*shadowOffset);
    [_secondDrawerController.view setFrame:drawerFrame];
    _secondDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _secondDrawerController.view.layer.cornerRadius = 4.0;
    [_secondDrawerController.view.layer setMasksToBounds:YES];
    [_secondDrawerView addSubview:_secondDrawerController.view];
    [self shouldEnableUserInteraction:NO];
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         _secondDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - drawerWidth - shadowOffset, _topOffset - shadowOffset, drawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             _secondDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - drawerWidth - shadowOffset, _topOffset - shadowOffset, drawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                             _secondDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
                             
                             UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
                             [_secondDrawerView addGestureRecognizer:panGesture];
                             [self shouldEnableUserInteraction:YES];
                         }
                     }];
}

- (void)setupDrawerController:(UIViewController*)controller withWidth:(CGFloat)drawerWidth {
    
    if (_firstDrawerController) {
        _secondDrawerController = controller;
        _secondDrawerWidth = drawerWidth;
    }
    else {
        _firstDrawerController = controller;
        _firstDrawerWidth = drawerWidth;
    }
}

- (void)hideFirstDrawer {
    [self hideDrawerView:_firstDrawerView];
}

- (void)hideSecondDrawer {
    [self hideDrawerView:_secondDrawerView];
}

- (void)resetDrawerFrames {
    if (_firstDrawerView) {
        _firstDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - _firstDrawerWidth - shadowOffset, _topOffset - shadowOffset, _firstDrawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
        _firstDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        
        [_firstDrawerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _firstDrawerView.frame.size.width - 2*shadowOffset, _firstDrawerView.frame.size.height - 2*shadowOffset)];
        _firstDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    if (_secondDrawerView) {
        _secondDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - _secondDrawerWidth - shadowOffset, _topOffset - shadowOffset, _secondDrawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
        _secondDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        
        [_secondDrawerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _secondDrawerView.frame.size.width - 2*shadowOffset, _secondDrawerView.frame.size.height - 2*shadowOffset)];
        _secondDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
}

#pragma mark -
#pragma mark - show/hide drawers
- (void)hideDrawerView:(UIView*)drawerView {
    
    CGRect drawerFrame = drawerView.frame;
    drawerFrame.origin.x = _bottomController.view.frame.size.width;
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         [drawerView setFrame:drawerFrame];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self removeDrawerView:drawerView animated:NO];
                         }
                     }];
}

- (void)showDrawerView:(UIView*)drawerView {
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         if (_firstDrawerView) {
                             _firstDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - _firstDrawerWidth - shadowOffset, _topOffset - shadowOffset, _firstDrawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                             _firstDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
                             
                             [_firstDrawerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _firstDrawerView.frame.size.width - 2*shadowOffset, _firstDrawerView.frame.size.height - 2*shadowOffset)];
                             _firstDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                         }
                         if (_secondDrawerView) {
                             _secondDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - _secondDrawerWidth - shadowOffset, _topOffset - shadowOffset, _secondDrawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                             _secondDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
                             
                             [_secondDrawerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _secondDrawerView.frame.size.width - 2*shadowOffset, _secondDrawerView.frame.size.height - 2*shadowOffset)];
                             _secondDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             if (_firstDrawerView) {
                                 _firstDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - _firstDrawerWidth - shadowOffset, _topOffset - shadowOffset, _firstDrawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                                 _firstDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
                                 
                                 [_firstDrawerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _firstDrawerView.frame.size.width - 2*shadowOffset, _firstDrawerView.frame.size.height - 2*shadowOffset)];
                                 _firstDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                             }
                         }
                         if (_secondDrawerView) {
                             _secondDrawerView.frame = CGRectMake(_bottomController.view.frame.size.width - _secondDrawerWidth - shadowOffset, _topOffset - shadowOffset, _secondDrawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset);
                             _secondDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
                             
                             [_secondDrawerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _secondDrawerView.frame.size.width - 2*shadowOffset, _secondDrawerView.frame.size.height - 2*shadowOffset)];
                             _secondDrawerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                         }
                     }];
}

- (void)removeDrawerView:(UIView*)drawerView animated:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.2f
                         animations:^{
                             if (drawerView) {
                                 [drawerView setAlpha:0.0];
                             }
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [self removeDrawerView:drawerView];
                             }
                         }];
    }
    else {
        [self removeDrawerView:drawerView];
    }
}

- (void)removeDrawerView:(UIView*)drawerView {
    
    [drawerView removeFromSuperview];
    if (drawerView == _firstDrawerView) {
        _firstDrawerView = nil;
        _firstDrawerController = nil;
    }
    else if (drawerView == _secondDrawerView) {
        _secondDrawerView = nil;
        _secondDrawerController = nil;
    }
}

#pragma mark -
#pragma mark - enable/disable user interaction
- (void)shouldEnableUserInteraction:(BOOL)enable {
    
    if (_bottomController) {
        [_bottomController.view setUserInteractionEnabled:enable];
    }
    if (_firstDrawerController) {
        [_firstDrawerController.view setUserInteractionEnabled:enable];
    }
    if (_secondDrawerController) {
        [_secondDrawerController.view setUserInteractionEnabled:enable];
    }
}

#pragma mark -
#pragma mark - pan gesture
- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture {
    
    CGPoint location = [panGesture locationInView:_bottomController.view];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _touchOffset = location.x;
    }
    else if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded) {
        [self panningEndedForView:panGesture.view];
    }
    else {
        UIView *viewPanned = panGesture.view;
        CGFloat drawerWidth = 0.0;
        if (viewPanned == _firstDrawerView) {
            if (_secondDrawerView) {
                return;
            }
            drawerWidth = _firstDrawerWidth;
        }
        else if (viewPanned == _secondDrawerView) {
            drawerWidth = _secondDrawerWidth;
        }
        CGFloat positionX = location.x - _touchOffset + (_bottomController.view.frame.size.width - drawerWidth);
        if (positionX < _bottomController.view.frame.size.width - (drawerWidth + shadowOffset)) {
            positionX = _bottomController.view.frame.size.width - (drawerWidth + shadowOffset);
        }
        [viewPanned setFrame:CGRectMake(positionX, _topOffset - shadowOffset, drawerWidth + 2*shadowOffset, _bottomController.view.frame.size.height + 2*shadowOffset)];
    }
}

- (void)panningEndedForView:(UIView*)viewPanned {
    
    if (viewPanned.frame.size.width/2 < (_bottomController.view.frame.size.width - viewPanned.frame.origin.x)) {
        [self showDrawerView:viewPanned];
    }
    else {
        [self hideDrawerView:viewPanned];
    }
}

@end
