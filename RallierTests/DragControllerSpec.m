#import "Kiwi.h"
#import "DragController.h"
#import "DefinedTableManager.h"
#import "CellTransferHelper.h"

SPEC_BEGIN(DragControllerSpec)

describe(@"Drag Controller", ^{

	__block DragController *sut;

	context(@"Construction", ^{

		beforeEach(^{
			id sourceDragManagerMock = [DefinedTableManager nullMockWithName:@"sourceDragManagerMock"];
			id cellTransferHelperMock = [CellTransferHelper nullMockWithName:@"cellTransferHelperMock"];

			sut = [[DragController alloc] initWithSource:sourceDragManagerMock helper:cellTransferHelperMock draggingView:nil ];
		});

		it(@"should have a sourceDragManager defined", ^{
			[[sut sourceDragManager] shouldNotBeNil];
		});

		it(@"should have dragging info defined", ^{
			[[sut draggingInfo] shouldNotBeNil];
		});
	});

});

SPEC_END
