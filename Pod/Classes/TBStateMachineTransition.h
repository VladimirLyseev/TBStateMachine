//
//  TBStateMachineTransition.h
//  TBStateMachine
//
//  Created by Julian Krumow on 16.06.14.
//  Copyright (c) 2014 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBStateMachineTransition.h"

@class TBStateMachineState;

/**
 *  This type represents an action of a given `TBStateMachineTransition`.
 *
 *  @param sourceState      The source `TBStateMachineState`.
 *  @param destinationState The destination `TBStateMachineState`.
 *  @param data             The payload data.
 */
typedef void(^TBStateMachineActionBlock)(TBStateMachineState *sourceState, TBStateMachineState *destinationState, NSDictionary *data);

/**
 *  This type represents a guard function of a given `TBStateMachineTransition`.
 *
 *  @param sourceState      The source `TBStateMachineNode`.
 *  @param destinationState The destination `TBStateMachineNode`.
 *  @param data      The payload data.
 */
typedef BOOL(^TBStateMachineGuardBlock)(TBStateMachineState *sourceState, TBStateMachineState *destinationState, NSDictionary *data);


/**
 *  This class represents a transition in a state machine.
 */
@interface TBStateMachineTransition : NSObject

/**
 *  The source state.
 */
@property (nonatomic, weak, readonly) TBStateMachineState *sourceState;

/**
 *  The destination state.
 */
@property (nonatomic, weak, readonly) TBStateMachineState *destinationState;

/**
 *  The action associated with the transition.
 */
@property (nonatomic, strong, readonly) TBStateMachineActionBlock action;

/**
 *  The guard function associated with the transition.
 */
@property (nonatomic, strong, readonly) TBStateMachineGuardBlock guard;

/**
 *  Creates a `TBStateMachineTransition` instance from a given source and destination state, action and guard.
 * 
 *  @param sourceState      The specified source state.
 *  @param destinationState The specified destination state.
 *  @param action           The action associated with this transition.
 *  @param guard            The guard function associated with the transition.
 *
 *  @return The transition object.
 */
+ (TBStateMachineTransition *)transitionWithSourceState:(TBStateMachineState *)sourceState destinationState:(TBStateMachineState *)destinationState action:(TBStateMachineActionBlock)action guard:(TBStateMachineGuardBlock)guard;

/**
 *  Initializes a `TBStateMachineTransition` instance from a given source and destination state, action and guard.
 *
 *  @param sourceState      The specified source state.
 *  @param destinationState The specified destination state.
 *  @param action           The action associated with this transition.
 *  @param guard            The guard function associated with the transition.
 *
 *  @return The transition object.
 */
- (instancetype)initWithSourceState:(TBStateMachineState *)sourceState destinationState:(TBStateMachineState *)destinationState action:(TBStateMachineActionBlock)action guard:(TBStateMachineGuardBlock)guard;

/**
 *  The transition's name.
 *
 *  @return the name.
 */
- (NSString *)name;

@end
