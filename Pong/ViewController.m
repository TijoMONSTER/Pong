//
//  ViewController.m
//  Pong
//
//  Created by Iván Mervich on 7/31/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "BallView.h"
#import "PaddleView.h"

@interface ViewController ()<UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet PaddleView *paddleView;
@property (weak, nonatomic) IBOutlet BallView *ballView;
@property UIDynamicAnimator *dynamicAnimator;
@property UIPushBehavior *pushBehavior;
@property UICollisionBehavior *collisionBehavior;
@property UIDynamicItemBehavior *ballDynamicBehavior;
@property UIDynamicItemBehavior *paddleDynamicBehavior;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView]
														 mode:UIPushBehaviorModeInstantaneous];

	self.pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
	self.pushBehavior.active = YES;
	self.pushBehavior.magnitude = 0.2;
	[self.dynamicAnimator addBehavior:self.pushBehavior];

	self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView]];
	self.collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
	self.collisionBehavior.collisionDelegate = self;
	self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
	[self.dynamicAnimator addBehavior:self.collisionBehavior];

	self.ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
	self.ballDynamicBehavior.allowsRotation = NO;
	self.ballDynamicBehavior.elasticity = 1.0;
	self.ballDynamicBehavior.friction = 0;
	self.ballDynamicBehavior.resistance = 0;
	[self.dynamicAnimator addBehavior:self.ballDynamicBehavior];

	self.paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
	self.paddleDynamicBehavior.allowsRotation = NO;
	self.paddleDynamicBehavior.density = 1000;
	[self.dynamicAnimator addBehavior:self.paddleDynamicBehavior];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
	NSLog(@"Collided");
}

- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
	self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, self.paddleView.center.y);
	[self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];

}


@end
