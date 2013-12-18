#import "Kiwi.h"
#import "DefinedTableManager.h"
#import "CellTransferHelper.h"
#import "TaskItem.h"

SPEC_BEGIN(DefinedTableManagerSpec)

	describe(@"DefinedTableManager", ^{
		__block DefinedTableManager *sut;
		__block id mockTableView;
		__block id mockDataSource;

		beforeEach(^{
			mockTableView = [UITableView nullMock];
			mockDataSource = [KWMock mockForProtocol:@protocol(TaskItemSourceProtocol)];
		});

		afterEach(^{
			sut = nil;
		});

		context(@"constructions", ^{
			__block KWCaptureSpy *delegateSpy;
			__block KWCaptureSpy *sourceSpy;

			beforeEach(^{
				delegateSpy = [mockTableView captureArgument:@selector(setDelegate:) atIndex:0];
				sourceSpy = [mockTableView captureArgument:@selector(setDataSource:) atIndex:0];
				sut = [[DefinedTableManager alloc] initWithTableView:mockTableView source:mockDataSource];
			});

			it(@"should conform to the table view delegate protocol", ^{
				[[sut should] conformToProtocol:@protocol(UITableViewDelegate)];
			});

			it(@"should create a UITableView", ^{
				[[sut view] shouldNotBeNil];
			});

			it(@"sets itself as its table view's delegate", ^{
				[[delegateSpy.argument should] equal:sut];
			});

			it(@"sets the passed source as the views data source", ^{
				[[sourceSpy.argument should] equal:mockDataSource];
			});

		});

		context(@"Getting data for dragging", ^{
			beforeEach(^{
				sut = [[DefinedTableManager alloc] initWithTableView:mockTableView source:mockDataSource];
			});

			it(@"should return a CellTransferHelper when given a point", ^{
				id mockTaskItem = [TaskItem nullMock];
				[[mockDataSource should] receive:@selector(itemForPosition:) andReturn:mockTaskItem];
				CellTransferHelper *expected = [sut getCellTransferInfoForPoint:CGPointMake(10, 10)];
				[[expected should] beKindOfClass:[CellTransferHelper class]];
			});
		});
	});

SPEC_END