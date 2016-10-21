// Generated by build_linux_main.sh
import XCTest
@testable import SignalsTests

XCTMain([
testCase([
("testBasicFiring", SignalQueueTests.testBasicFiring),
("testCancellingListeners", SignalQueueTests.testCancellingListeners),
("testConditionalListening", SignalQueueTests.testConditionalListening),
("testDispatchQueueing", SignalQueueTests.testDispatchQueueing),
("testListenerProperty", SignalQueueTests.testListenerProperty),
("testListeningNoData", SignalQueueTests.testListeningNoData),
("testListeningOnDispatchQueue", SignalQueueTests.testListeningOnDispatchQueue),
("testNoQueueTimeFiring", SignalQueueTests.testNoQueueTimeFiring),
("testUsesCurrentQueueByDefault", SignalQueueTests.testUsesCurrentQueueByDefault),
]),
testCase([
("testBasic", SignalsChainingTests.testBasic),
("testBreakChain", SignalsChainingTests.testBreakChain),
("testDelay", SignalsChainingTests.testDelay),
("testPersistence", SignalsChainingTests.testPersistence),
]),
testCase([
("testAutoRemoveWeakListeners", SignalsTests.testAutoRemoveWeakListeners),
("testBasicFiring", SignalsTests.testBasicFiring),
("testCancellingListeners", SignalsTests.testCancellingListeners),
("testConditionalListening", SignalsTests.testConditionalListening),
("testConditionalListeningOnce", SignalsTests.testConditionalListeningOnce),
("testDataRetention", SignalsTests.testDataRetention),
("testListeningOnce", SignalsTests.testListeningOnce),
("testListeningPastOnceAlreadyFired", SignalsTests.testListeningPastOnceAlreadyFired),
("testListeningPastOnceNotFiredYet", SignalsTests.testListeningPastOnceNotFiredYet),
("testMultiArgumentFiring", SignalsTests.testMultiArgumentFiring),
("testMultiFiring", SignalsTests.testMultiFiring),
("testMultiListenersManyObjects", SignalsTests.testMultiListenersManyObjects),
("testMultiListenersOneObject", SignalsTests.testMultiListenersOneObject),
("testNoArgumentFiring", SignalsTests.testNoArgumentFiring),
("testPerformanceFiring", SignalsTests.testPerformanceFiring),
("testPostListening", SignalsTests.testPostListening),
("testPostListeningNoData", SignalsTests.testPostListeningNoData),
("testRemoveAllListenersWhileFiring", SignalsTests.testRemoveAllListenersWhileFiring),
("testRemoveOwnListenerWhileFiring", SignalsTests.testRemoveOwnListenerWhileFiring),
("testRemovePreviousListenersWhileFiring", SignalsTests.testRemovePreviousListenersWhileFiring),
("testRemoveUpcomingListenersWhileFiring", SignalsTests.testRemoveUpcomingListenersWhileFiring),
("testRemovingAllListeners", SignalsTests.testRemovingAllListeners),
("testRemovingListeners", SignalsTests.testRemovingListeners),

])])
