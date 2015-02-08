//
//  TBSMState.h
//  TBStateMachine
//
//  Created by Julian Krumow on 16.06.14.
//  Copyright (c) 2014 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBSMNode.h"
#import "TBSMTransitionKind.h"

FOUNDATION_EXPORT NSString * const TBSMSourceStateUserInfo;
FOUNDATION_EXPORT NSString * const TBSMTargetStateUserInfo;
FOUNDATION_EXPORT NSString * const TBSMDataUserInfo;

/**
 *  This type represents a block that is executed on entry and exit of a `TBSMState`.
 *
 *  @param sourceState      The source state.
 *  @param targetState The destination state.
 *  @param data The payload data.
 */
typedef void (^TBSMStateBlock)(TBSMState *sourceState, TBSMState *targetState, NSDictionary *data);

/**
 *  This class represents a state in a state machine.
 */
@interface TBSMState : NSObject<TBSMNode>

/**
 *  The state's parent state inside the state machine hierarchy.
 */
@property (nonatomic, weak) id<TBSMNode> parentNode;

/**
 *  Block that is executed when the state is entered.
 */
@property (nonatomic, copy) TBSMStateBlock enterBlock;

/**
 *  Block that is executed when the state is exited.
 */
@property (nonatomic, copy) TBSMStateBlock exitBlock;

/**
 *  All `TBSMEvent` instances registered to this state instance.
 */
@property (nonatomic, strong, readonly) NSDictionary *eventHandlers;

/**
 *  All `TBSMEvent` instances deferred by this state instance.
 */
@property (nonatomic, strong, readonly) NSDictionary *deferredEvents;

/**
 *  Creates a `TBSMState` instance from a given name.
 *
 *  Throws a `TBSMException` when name is nil or an empty string.
 *
 *  @param name The specified state name.
 *
 *  @return The state instance.
 */
+ (TBSMState *)stateWithName:(NSString *)name;

/**
 *  Initializes a `TBSMState` with a specified name.
 *
 *  Throws a `TBSMException` when name is nil or an empty string.
 *
 *  @param name The name of the state. Must be unique.
 *
 *  @return An initialized `TBSMState` instance.
 */
- (instancetype)initWithName:(NSString *)name;

/**
 *  Registers an event of a given name for transition to a specified target state.
 *  Defaults to external transition.
 *
 *  Throws a `TBSMException` if the specified event is already listed as deferred by this state.
 *  See deferevent:
 *
 *  @param event  The given event name.
 *  @param target The destination `TBSMState` instance. Can be `nil` for internal transitions.
 */
- (void)addHandlerForEvent:(NSString *)event target:(TBSMState *)target;

/**
 *  Registers an event of a given name for transition to a specified target state.
 *
 *  Throws a `TBSMException` if the specified event is already listed as deferred by this state.
 *  See deferevent:
 *
 *  @param event  The given event name.
 *  @param target The destination `TBSMState` instance. Can be `nil` for internal transitions.
 *  @param kind   The kind of transition.
 */
- (void)addHandlerForEvent:(NSString *)event target:(TBSMState *)target kind:(TBSMTransitionKind)kind;

/**
 *  Registers an event of a given name for transition to a specified target state.
 *  If target parameter is `nil` an internal transition will be performed using the action block.
 *
 *  Throws a `TBSMException` if the specified event is already listed as deferred by this state.
 *  See deferevent:
 *
 *  @param event  The given event name.
 *  @param target The destination `TBSMState` instance. Can be `nil` for internal transitions.
 *  @param kind   The kind of transition.
 *  @param action The action block associated with this event.
 */
- (void)addHandlerForEvent:(NSString *)event target:(TBSMState *)target kind:(TBSMTransitionKind)kind action:(TBSMActionBlock)action;

/**
 *  Registers an event of a given name for transition to a specified target state.
 *  If target parameter is `nil` an internal transition will be performed using guard and action block.
 *
 *  Throws a `TBSMException` if the specified event is already listed as deferred by this state.
 *  See deferevent:
 *
 *  @param event  The given event name.
 *  @param target The destination `TBSMState` instance. Can be `nil` for internal transitions.
 *  @param kind   The kind of transition.
 *  @param action The action block associated with this event.
 *  @param guard  The guard block associated with this event.
 */
- (void)addHandlerForEvent:(NSString *)event target:(TBSMState *)target kind:(TBSMTransitionKind)kind action:(TBSMActionBlock)action guard:(TBSMGuardBlock)guard;

/**
 *  Registers an event of a given name which should be deferred when received by this state instance.
 *
 *  Throws a `TBSMException` if the specified event is already registered on this state.
 *  See addHandlerForEvent:target:action:guard:
 *
 *  @param event  The given event name.
 */
- (void)deferEvent:(NSString *)event;

/**
 *  Returns `YES` if a given event can be handled by the state.
 *
 *  @param event The event to check.
 *
 *  @return `YES` if the event can be handled.
 */
- (BOOL)canHandleEvent:(TBSMEvent *)event;

/**
 *  Returns `YES` if a given event can be defered by the state.
 *
 *  @param event The event to check.
 *
 *  @return `YES` if the event can be defered.
 */
- (BOOL)canDeferEvent:(TBSMEvent *)event;

/**
 *  Returns an array of  `TBSMEventHandler` instances for a given event.
 *
 *  @param event The event to handle
 *
 *  @return The array containing the corresponding event handlers.
 */
- (NSArray *)eventHandlersForEvent:(TBSMEvent *)event;

/**
 *  Executes the enter block of the state.
 *
 *  @param sourceState      The source state.
 *  @param targetState The destination state.
 *  @param data             The payload data.
 */
- (void)enter:(TBSMState *)sourceState targetState:(TBSMState *)targetState data:(NSDictionary *)data;

/**
 *  Executes the exit block of the state.
 *
 *  @param sourceState      The source state.
 *  @param targetState The destination state.
 *  @param data             The payload data.
 */
- (void)exit:(TBSMState *)sourceState targetState:(TBSMState *)targetState data:(NSDictionary *)data;

@end
