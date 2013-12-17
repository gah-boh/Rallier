#import "Kiwi.h"
#import "CellTransferHelper.h"
#import "TaskItem.h"

SPEC_BEGIN(CellTransferHelperSpec)

	describe(@"CellTransferHelper", ^{
		context(@"Construction", ^{
			__block CellTransferHelper *sut;

			beforeEach(^{
				id taskMock = [TaskItem mock];
				int arrayPosition = 1;
				id cellMock = [UITableViewCell mock];
				sut = [[CellTransferHelper alloc] initWithTaskItem:taskMock cell:cellMock arrayPosition:arrayPosition];
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
				[[theValue([sut arrayPosition]) should] equal:theValue(1)];
			});

			it(@"should have a cell property defined", ^{
				[[sut cell] shouldNotBeNil];
			});
		});
	});

SPEC_END