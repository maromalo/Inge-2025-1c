!classDefinition: #CashierTest category: #'IRobot-Enunciado'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'F 5/21/2020 21:50:00'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aCashier receiveOrder: aRobot 
		]
		raise: Error
		withMessageText: Cashier trailerIsEmptyErrorDescription.
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'F 5/21/2020 21:50:32'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aRobot withMechanicalFailure.
			aCashier receiveOrder: aRobot 
		]
		raise: Error
		withMessageText: Cashier trailerIsEmptyErrorDescription.
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'F 5/20/2020 23:18:54'!
test03ShouldNotAcceptSensorsFailureRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aRobot withSensorsFailure.
			aCashier receiveOrder: aRobot ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'F 5/20/2020 23:47:15'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aRobot take: (ProductA with: 1  and: 1).
			aRobot withMechanicalFailure.
			
			aCashier receiveOrder: aRobot.
			
			aRobot take: (ProductA with: 1 and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.

! !


!classDefinition: #ProductTest category: #'IRobot-Enunciado'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:46'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ Product with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:51'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ Product with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: #'IRobot-Enunciado'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 18:26:53'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 18:48:41'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: #'IRobot-Enunciado'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:29:39'!
test01CanNotCreateTrailerWithCeroOrLessMaxWeight

	self
		should: [ Trailer with: 0  and: 100 ]
		raise: Error
		withMessageText: Trailer invalidWeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:30:47'!
test02CanNotCreateTrailerWithCeroOrLessMaxHeight

	self
		should: [ Trailer with: 1  and: 0 ]
		raise: Error
		withMessageText: Trailer invalidHeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:41:04'!
test03CanNotCreateTrailerWithNoIntegerMaxWeight

	self
		should: [ Trailer with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Trailer weightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:41:29'!
test04CanNotCreateTrailerWithNoIntegerMaxHeight

	self
		should: [ Trailer with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Trailer heightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:43:36'!
test05ShouldRejectProductAIfWeightExceeded

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (ProductA with: 21 and: 1) ]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:43:28'!
test06ShouldRejectProductBIfWeightExceeded

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (ProductB with: 21 and: 1) ]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/5/2020 11:27:50'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.
	
	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
		
	self assert: aTrailer totalProductsAmount equals: 4.
	self assert: aTrailer totalProductsWeight equals: 10.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/5/2020 11:27:57'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.
	
	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
	aTrailer carry: (ProductB with: 1 and: 1).
	
	self assert: aTrailer totalProductsAmount equals: 5.
	self assert: aTrailer totalProductsWeight equals: 11.! !


!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:03'!
test09ShouldAcceptProductAIgnoringMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: 0.
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:07'!
test10ShouldIgnoreAProductsInMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:16'!
test11ShouldRejectProductBExceedingMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		should: [aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)] 
		raise: Error
		withMessageText: Trailer maxHeightExceededErrorDescription.
	
	self assert: aTrailer totalProductsAmount equals: 1.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !


!classDefinition: #Cashier category: #'IRobot-Enunciado'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Cashier methodsFor: 'closing buy order' stamp: 'MARO 5/2/2025 13:28:04'!
receiveOrder: aRobot
	
	^aRobot status cashier: self evaluationOf: aRobot.
! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !

!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'IRobot-Enunciado'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: #'IRobot-Enunciado'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Product methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 10:39:55'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'IRobot-Enunciado'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:47:40'!
with: aWeight and: aHeight
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^ self new initializeWith: aWeight and: aHeight! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: #'IRobot-Enunciado'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: #'IRobot-Enunciado'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: #'IRobot-Enunciado'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Robot methodsFor: 'actions' stamp: 'MARO 5/2/2025 13:45:25'!
closeOrderUsing: aCashier

	^status closeOrderBy: self using: aCashier.! !

!Robot methodsFor: 'actions' stamp: 'MARO 5/2/2025 12:49:10'!
take: aProduct

	status take: aProduct with: trailer.! !


!Robot methodsFor: 'status' stamp: 'MARO 5/2/2025 14:42:24'!
outOfOrder

	status := RobotOutOfOrder.
! !

!Robot methodsFor: 'status' stamp: 'MARO 5/2/2025 14:42:14'!
withMechanicalFailure

	status := RobotMechanicalFailure.
! !

!Robot methodsFor: 'status' stamp: 'MARO 5/2/2025 14:42:39'!
withSensorsFailure

	status := RobotSensorsFailure.
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/4/2020 18:35:21'!
status

	^ status
! !

!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'initialization' stamp: 'MARO 5/2/2025 14:42:49'!
initializeWith: aTrailer

	status := RobotWorkingNormal.
	trailer := aTrailer.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'IRobot-Enunciado'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'MARO 5/2/2025 12:36:47'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 18:26:04'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 18:26:32'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotCashierBehavior category: #'IRobot-Enunciado'!
Object subclass: #RobotCashierBehavior
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotCashierBehavior class' category: #'IRobot-Enunciado'!
RobotCashierBehavior class
	instanceVariableNames: ''!

!RobotCashierBehavior class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:07:51'!
cashier: aCashier evaluationOf: aRobot

	^self subclassResponsibility! !

!RobotCashierBehavior class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:45:23'!
closeOrderBy: aRobot using: aCashier
	
	^aCashier receiveOrder: aRobot.! !

!RobotCashierBehavior class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:46:08'!
take: aProduct with: aTrailer

	 ^aTrailer carry: aProduct.! !


!classDefinition: #RobotMechanicalFailure category: #'IRobot-Enunciado'!
RobotCashierBehavior subclass: #RobotMechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotMechanicalFailure class' category: #'IRobot-Enunciado'!
RobotMechanicalFailure class
	instanceVariableNames: ''!

!RobotMechanicalFailure class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:08:10'!
cashier: aCashier evaluationOf: aRobot
	| aTrailer |
	aRobot outOfOrder.
		
	aTrailer := aRobot trailer.	
	aCashier assertTrailerNotEmpty: aTrailer.
		
		"Comentario: en este punto el cashier realizaría el checkout de los productos."

	^ true.! !


!classDefinition: #RobotOutOfOrder category: #'IRobot-Enunciado'!
RobotCashierBehavior subclass: #RobotOutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotOutOfOrder class' category: #'IRobot-Enunciado'!
RobotOutOfOrder class
	instanceVariableNames: ''!

!RobotOutOfOrder class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:08:16'!
closeOrderBy: aRobot using: aCashier

	^ Robot signalOutOfOrder! !

!RobotOutOfOrder class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:08:19'!
take: aProduct with: aTrailer
	^ Robot signalOutOfOrder.! !


!classDefinition: #RobotSensorsFailure category: #'IRobot-Enunciado'!
RobotCashierBehavior subclass: #RobotSensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotSensorsFailure class' category: #'IRobot-Enunciado'!
RobotSensorsFailure class
	instanceVariableNames: ''!

!RobotSensorsFailure class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:08:24'!
cashier: aCashier evaluationOf: aRobot

	aRobot outOfOrder.
	aCashier signalRobotSensorsFailure.! !


!classDefinition: #RobotWorkingNormal category: #'IRobot-Enunciado'!
RobotCashierBehavior subclass: #RobotWorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotWorkingNormal class' category: #'IRobot-Enunciado'!
RobotWorkingNormal class
	instanceVariableNames: ''!

!RobotWorkingNormal class methodsFor: 'actions' stamp: 'MARO 5/2/2025 14:08:36'!
cashier: aCashier evaluationOf: aRobot
	|aTrailer|
	aTrailer := aRobot trailer.	
	aCashier assertTrailerNotEmpty: aTrailer.
		
		"Comentario: en este punto el cashier realizaría el checkout de los productos."
		
	^ true! !


!classDefinition: #Trailer category: #'IRobot-Enunciado'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'MARO 5/2/2025 15:13:09'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"
	^(container select: [:product | product isStackable]	) sum: [:product | product height] ifEmpty: 0! !

!Trailer methodsFor: 'accessing' stamp: 'MARO 5/2/2025 15:04:20'!
totalProductsWeight
	
	^container sum: [:product | product weight] ifEmpty: 0.! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 19:08:17'!
carryProductA: aProduct
	
	self assertWeightAdding: aProduct.
	container add: aProduct.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 19:08:09'!
carryProductB: aProduct

	self assertWeightAdding: aProduct.
	self assertHeightAdding: aProduct.
	
	container add: aProduct.! !


!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:29'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:41'!
assertWeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ]! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'IRobot-Enunciado'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:33:58'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !
