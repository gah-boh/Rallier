#import "Kiwi.h"
#import "DragController.h"
#import "KanbanTableManager.h"
#import "CellTransferHelper.h"

SPEC_BEGIN(DragControllerSpec)

describe(@"Drag Controller", ^{

	__block DragController *sut;
	__block id sourceDragManagerMock;
	__block id cellTransferHelperMock;
	__block id cellMock;

	beforeEach(^{
		sourceDragManagerMock = [KanbanTableManager nullMockWithName:@"sourceDragManagerMock"];
		cellTransferHelperMock = [CellTransferHelper nullMockWithName:@"cellTransferHelperMock"];
		cellMock = [UITableViewCell nullMockWithName:@"cellMock"];

		sut = [[DragController alloc] initWithSource:sourceDragManagerMock helper:cellTransferHelperMock draggedCell:cellMock];
	});
	
	afterEach(^{
		sut = nil;
	});

	context(@"Construction", ^{

		it(@"should have a sourceDragManager defined", ^{
			[[sut sourceDragManager] shouldNotBeNil];
		});

		it(@"should have dragging info defined", ^{
			[[sut draggingInfo] shouldNotBeNil];
		});

		it(@"should have a cell defined", ^{
			[[sut draggedCell] shouldNotBeNil];
		});
	});

	context(@"dragging", ^{
		it(@"dragCell given a translation should call setCenter on the cell", ^{
			CGPoint translation = CGPointMake(5.0, 0.0);
			[[cellMock should] receive:@selector(setCenter:)];
			[sut dragCell:translation];
		});

		it(@"dragEndedAt: should tell the sourceDragManager to removeCellAndDataFromPositon:", ^{
			[[[sut sourceDragManager] should] receive:@selector(removeCell:data:)];
			[sut dragEndedAt:nil];
		});

		it(@"dragEndedAt: should tell the destinationTableManager newItemDragged:", ^{
			id destinationMock = [KanbanTableManager nullMockWithName:@"destinationTableManagerMock"];
			[[destinationMock should] receive:@selector(newItemDragged:)];
			[sut dragEndedAt:destinationMock];
		});
	});

});

SPEC_END
