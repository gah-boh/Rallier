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
			sut = [[DefinedTableManager alloc] initWithTableView:mockTableView source:mockDataSource];
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

			it(@"should have a global variable of rowHeight that is bigger than 0", ^{
				[[theValue(rowHeight) should] beGreaterThan:theValue(0)];
			});

		});

		context(@"Getting data for dragging", ^{

			it(@"should return a CellTransferHelper when given a point", ^{
				id mockTaskItem = [TaskItem nullMock];
				[[mockDataSource should] receive:@selector(itemForPosition:) andReturn:mockTaskItem];
				CellTransferHelper *expected = [sut getCellTransferInfoForPoint:CGPointMake(10, 10)];
				[[expected should] beKindOfClass:[CellTransferHelper class]];
			});

			it(@"cellForIndexPath: should call the data source cellForIndexPath:", ^{
				[[mockDataSource should] receive:@selector(tableView:cellForRowAtIndexPath:)];
				[sut cellForIndexPath:nil];
			});
		});

		context(@"Adding data", ^{

			it(@"removeCellAndDataFromPosition should call removeDataForPosition from data source", ^{
				[[mockDataSource should] receive:@selector(removeDataForPosition:)];
				[sut removeCellAndDataFromPosition:nil];
			});

			it(@"newItemDraggeds should add the data to the data source", ^{
				[[mockDataSource should] receive:@selector(addData:)];
				[sut newItemDragged:nil];
			});

			it(@"newItemDraggeds should add the data to the data source", ^{
				id mockData = [TaskItem nullMockWithName:@"mockData"];
				[[mockDataSource should] receive:@selector(addData:) withArguments:mockData];
				[sut newItemDragged:mockData];
			});

		});
	});

SPEC_END