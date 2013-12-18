#import "Kiwi.h"
#import "CellTransferHelper.h"
#import "TaskItem.h"

SPEC_BEGIN(CellTransferHelperSpec)

	describe(@"CellTransferHelper", ^{
		context(@"Construction", ^{
			__block CellTransferHelper *sut;

			beforeEach(^{
				id taskMock = [TaskItem mock];
				NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
				id cellMock = [UITableViewCell mock];
				sut = [[CellTransferHelper alloc] initWithTaskItem:taskMock cell:cellMock position:indexPath];
			});

			it(@"should not allow you to use init", ^{
				[[theBlock(^{
					[[CellTransferHelper alloc] init];
				}) should] raise];
			});

			it(@"should have a TaskItem property defined", ^{
				[[sut taskItem] shouldNotBeNil];
			});

			it(@"should have an array position", ^{
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
				[[[sut indexPath] should] equal:indexPath];
			});

			it(@"should have a cell property defined", ^{
				[[sut cell] shouldNotBeNil];
			});
		});
	});

SPEC_END