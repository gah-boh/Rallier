#import "Kiwi.h"
#import "CellTransferHelper.h"
#import "TaskItem.h"

SPEC_BEGIN(CellTransferHelperSpec)

	describe(@"CellTransferHelper", ^{
		context(@"Construction", ^{
			__block CellTransferHelper *sut;

			beforeEach(^{
				id taskMock = [TaskItem nullMockWithName:@"taskMock"];
				id cellMock = [UITableViewCell nullMockWithName:@"cellMock"];
				sut = [[CellTransferHelper alloc] initWithTaskItem:taskMock cell:cellMock position:1];
			});

			it(@"should not allow you to use init", ^{
				[[theBlock(^{
					sut = [[CellTransferHelper alloc] init];
				}) should] raise];
			});

			it(@"should have a TaskItem property defined", ^{
				[[sut taskItem] shouldNotBeNil];
			});

			it(@"should have an array position", ^{
				[[theValue([sut position]) should] equal:theValue(1)];
			});

			it(@"should have a cell property defined", ^{
				[[sut cell] shouldNotBeNil];
			});

		});
	});

SPEC_END