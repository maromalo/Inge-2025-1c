!classDefinition: #CashierTest category: 'IRobot-Solucion'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'FRT 4/15/2025 09:12:08'!
shouldRaise: errorMessage when: aBlock

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ aBlock value: aRobot value: aCashier ]
		raise: Error
		withMessageText: errorMessage.
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'FRT 5/4/2020 11:47:39'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot

	self 
		shouldRaise: Cashier trailerIsEmptyErrorDescription 
		when: [ :aRobot :aCashier | aCashier receiveOrderFromNormal: aRobot ]
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'FRT 6/11/2020 17:02:13'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	self 
		shouldRaise: Cashier trailerIsEmptyErrorDescription 
		when: [ :aRobot :aCashier | 
			aRobot withMechanicalFailure.
			aCashier receiveOrderFromMechanicalFailure: aRobot 
		]
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'F 5/5/2020 11:22:18'!
test03ShouldNotAcceptSensorsFailureRobot

	self 
		shouldRaise: Cashier robotSensorsFailureErrorDescription 
		when: [ :aRobot :aCashier | 
			aRobot withSensorsFailure.
			aCashier receiveOrderFromSensorsFailure: aRobot 
		]
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'FRT 4/15/2025 09:11:55'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	self 
		shouldRaise: Robot outOfOrderErrorDescription
		when: [ :aRobot :aCashier |
			aRobot take: (ProductA with: 1 * kilogram and: 1 * meter).
			aRobot withMechanicalFailure.
			
			aCashier receiveOrderFromMechanicalFailure: aRobot.			
			
			aRobot take: (ProductA with: 1 * kilogram and: 1 * meter).
		]
! !


!classDefinition: #ProductTest category: 'IRobot-Solucion'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:08:09'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ ProductA with: 0 * kilogram and: 100 * meter ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:08:18'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ ProductA with: 100 * kilogram and: 0 * meter ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:08:28'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5 * kilogram and: 100 * meter]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:08:37'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100 * kilogram and: 1.5 * meter ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: 'IRobot-Solucion'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:04:55'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aTrailer carry: (ProductA with: 1 * kilogram  and: 1 * meter).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 4/15/2025 09:05:19'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1 * kilogram  and: 1 * meter).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 4/15/2025 09:05:43'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 *kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1 *kilogram  and: 1 * meter).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 4/15/2025 09:06:14'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1 *kilogram and: 1 * meter).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 4/15/2025 09:06:38'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1 * kilogram  and: 1 * meter) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 4/15/2025 09:06:55'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1 * kilogram and: 1 * meter).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 4/15/2025 09:07:17'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1 * kilogram and: 1 * meter).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 4/15/2025 09:07:32'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1 * kilogram and: 1 * meter).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 4/15/2025 09:07:48'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 * kilogram and: 100 * meter.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1 * kilogram and: 1 * meter).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: 'IRobot-Solucion'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:09:10'!
shouldAcceptProducts: aTrailerBlock withAmount: anExpectedAmount andWeight: anExpectedWeight  

	| aTrailer |
	aTrailer := Trailer with: 11 * kilogram  and: 100 * meter.
	
	aTrailer carry: (ProductA with: 1 * kilogram and: 1 * meter).
	aTrailer carry: (ProductA with: 2 * kilogram and: 1 * meter).
	aTrailer carry: (ProductB with: 3 * kilogram and: 1 * meter).
	aTrailer carry: (ProductB with: 4 * kilogram and: 1 * meter).
	aTrailerBlock value: aTrailer.
		
	self assert: aTrailer totalProductsAmount equals: anExpectedAmount.
	self assert: aTrailer totalProductsWeight equals: anExpectedWeight ! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:09:25'!
shouldSignalMaxWeightExceededErrorDescriptionWhenAdding: aProductType

	| aTrailer |
	aTrailer := Trailer with: 20 * kilogram  and: 100 * meter.
	
	self
		should: [ aTrailer carry: (aProductType with: 21 * kilogram and: 1 * meter)]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:08:59'!
test01CanNotCreateTrailerWithCeroOrLessMaxWeight

	self
		should: [ Trailer with: 0 * kilogram  and: 100 * meter ]
		raise: Error
		withMessageText: Trailer invalidWeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:09:39'!
test02CanNotCreateTrailerWithCeroOrLessMaxHeight

	self
		should: [ Trailer with: 1 * kilogram  and: 0 * meter ]
		raise: Error
		withMessageText: Trailer invalidHeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:09:46'!
test03CanNotCreateTrailerWithNoIntegerMaxWeight

	self
		should: [ Trailer with: 1.5 * kilogram  and: 100 * meter ]
		raise: Error
		withMessageText: Trailer weightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:09:54'!
test04CanNotCreateTrailerWithNoIntegerMaxHeight

	self
		should: [ Trailer with: 100 * kilogram  and: 1.5 * meter ]
		raise: Error
		withMessageText: Trailer heightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 16:46:28'!
test05ShouldRejectProductAIfWeightExceeded

	self shouldSignalMaxWeightExceededErrorDescriptionWhenAdding: ProductA ! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 16:45:53'!
test06ShouldRejectProductBIfWeightExceeded

	self shouldSignalMaxWeightExceededErrorDescriptionWhenAdding: ProductB
	! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:10:04'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity

	self shouldAcceptProducts: [ :trailer | ] withAmount: 4 andWeight: 10 * kilogram.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 4/15/2025 09:10:17'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity

	self shouldAcceptProducts: [ :trailer | trailer carry: (ProductB with: 1 * kilogram and: 1 * meter).] withAmount: 5 andWeight: 11 * kilogram.
! !


!TrailerTest methodsFor: 'height capacity' stamp: 'HAW 6/7/2020 15:25:07'!
assertHeightShouldBe: anExpectedHeightBlock whenAdding: aProductTypeToAdd 

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (aProductTypeToAdd with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: (anExpectedHeightBlock value: halfExceededHeightCapacity)! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 6/11/2020 16:54:16'!
test09ShouldAcceptNonStackableProductsIgnoringHeightCapacity

	self assertHeightShouldBe: [ :aHeight | 0 ] whenAdding: ProductA! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 6/11/2020 17:00:21'!
test10ShouldIgnoreNonStackableProductsWhenAddingStackableProduct

	self assertHeightShouldBe: [ :aHeight | aHeight ] whenAdding: ProductB! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 6/11/2020 16:58:06'!
test11ShouldRejectStackableProductExceedingHeightCapacity

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


!classDefinition: #Cashier category: 'IRobot-Solucion'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!Cashier methodsFor: 'accept buy order' stamp: 'F 5/14/2020 11:01:58'!
acceptProductsFrom: aRobot

	| aTrailer |

	aTrailer := aRobot trailer.	
	self assertTrailerNotEmpty: aTrailer.
		
	"Comentario: en este punto el cashier realizaría el checkout de los productos."

	^ true! !


!Cashier methodsFor: 'receiving buy order' stamp: 'FRT 5/4/2020 11:19:10'!
receiveOrderFromMechanicalFailure: aRobot
	
	aRobot outOfOrder.
	^ self acceptProductsFrom: aRobot.! !

!Cashier methodsFor: 'receiving buy order' stamp: 'FRT 5/4/2020 11:19:01'!
receiveOrderFromNormal: aRobot
	
	^ self acceptProductsFrom: aRobot! !

!Cashier methodsFor: 'receiving buy order' stamp: 'FRT 5/3/2020 23:01:39'!
receiveOrderFromSensorsFailure: aRobot
	
	aRobot outOfOrder.
	self signalRobotSensorsFailure! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'IRobot-Solucion'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: 'IRobot-Solucion'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

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

!classDefinition: 'Product class' category: 'IRobot-Solucion'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:04:10'!
with: aWeight and: aHeight
	
	aWeight amount strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight amount strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight amount isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight amount isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
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


!classDefinition: #ProductA category: 'IRobot-Solucion'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: 'IRobot-Solucion'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: 'IRobot-Solucion'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!Robot methodsFor: 'actions' stamp: 'HAW 6/7/2020 15:33:01'!
closeOrderUsing: aCashier

	^ status closeOrderUsing: aCashier! !

!Robot methodsFor: 'actions' stamp: 'FRT 5/3/2020 22:40:35'!
take: aProduct

	status take: aProduct! !


!Robot methodsFor: 'status' stamp: 'FRT 5/3/2020 22:42:57'!
outOfOrder

	status := OutOfOrder for: self
! !

!Robot methodsFor: 'status' stamp: 'FRT 5/3/2020 22:50:41'!
withMechanicalFailure

	status := MechanicalFailure for: self
! !

!Robot methodsFor: 'status' stamp: 'FRT 5/3/2020 22:50:45'!
withSensorsFailure

	status := SensorsFailure for: self
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'initialization' stamp: 'FRT 5/4/2020 11:05:43'!
initializeWith: aTrailer

	trailer := aTrailer.
	status := WorkingNormal for: self.
! !


!Robot methodsFor: 'status related' stamp: 'FRT 5/3/2020 22:41:23'!
carry: aProduct

	trailer carry: aProduct! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: 'IRobot-Solucion'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'F 5/5/2020 11:17:36'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'F 5/5/2020 11:18:28'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotStatus category: 'IRobot-Solucion'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!RobotStatus methodsFor: 'initialization' stamp: 'FRT 5/3/2020 21:32:00'!
initializeWith: aRobot

	robot := aRobot! !


!RobotStatus methodsFor: 'robot actions' stamp: 'FRT 6/12/2020 10:35:01'!
closeOrderUsing: aCashier

	self subclassResponsibility! !

!RobotStatus methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:38:22'!
take: aProduct

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotStatus class' category: 'IRobot-Solucion'!
RobotStatus class
	instanceVariableNames: ''!

!RobotStatus class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 21:30:55'!
for: aRobot
	
	^ self new initializeWith: aRobot! !


!classDefinition: #MechanicalFailure category: 'IRobot-Solucion'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:46:51'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromMechanicalFailure: robot
	! !

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:44:39'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #OutOfOrder category: 'IRobot-Solucion'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'F 5/5/2020 11:20:34'!
closeOrderUsing: aCashier
	
	Robot signalOutOfOrder! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'HAW 6/7/2020 15:32:51'!
take: aProduct
	
	Robot signalOutOfOrder! !


!classDefinition: #SensorsFailure category: 'IRobot-Solucion'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:54'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromSensorsFailure: robot! !

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:43:35'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #WorkingNormal category: 'IRobot-Solucion'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:19'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromNormal: robot! !

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:41:15'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #Trailer category: 'IRobot-Solucion'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Solucion'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accesing totals' stamp: 'HAW 6/7/2020 13:34:29'!
total: aContainer using: aBlock
	
	^ aContainer sum: [ :aProduct |  (aBlock value: aProduct) ] ifEmpty: [ 0 ]! !

!Trailer methodsFor: 'accesing totals' stamp: 'FRT 5/4/2020 10:28:36'!
totalHeight: aContainer

	^ self total: aContainer using: [ :aProduct | aProduct height ]! !

!Trailer methodsFor: 'accesing totals' stamp: 'FRT 5/4/2020 10:28:15'!
totalWeight: aContainer

	^ self total: aContainer using: [ :aProduct | aProduct weight ]! !


!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/5/2020 11:14:31'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"
	
	^ self totalHeight: (container select: [ :aProduct | aProduct isStackable])! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/5/2020 11:14:17'!
totalProductsWeight
	
	^ self totalWeight: container.! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 10:17:59'!
add: aProduct asserting: aBlock

	aBlock value.
	container add: aProduct.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 10:19:42'!
carryProductA: aProduct
	
	self add: aProduct 
		 asserting: [ 
			self assertWeightAdding: aProduct.
	 	 ]
	! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 10:50:33'!
carryProductB: aProduct

	self add: aProduct 
		 asserting: [ 
			self assertWeightAdding: aProduct.
			self assertHeightAdding: aProduct.
	 	 ]
! !


!Trailer methodsFor: 'assertions' stamp: 'F 5/5/2020 11:14:31'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'F 5/5/2020 11:14:17'!
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

!classDefinition: 'Trailer class' category: 'IRobot-Solucion'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 4/15/2025 09:03:07'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity amount strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity amount strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity amount isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity amount isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
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
