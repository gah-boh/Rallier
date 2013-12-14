#import "Kiwi.h"
#import "DefinedTableManager.h"

SPEC_BEGIN(DefinedTableManagerSpec)

	describe(@"DefinedTableManager", ^{
		__block DefinedTableManager *sut;

		afterEach(^{
			sut = nil;
		});

		context(@"constructions", ^{
			__block id mockTableView;
			__block KWCaptureSpy *delegateSpy;

			beforeEach(^{
				mockTableView = [UITableView mock];
				delegateSpy = [mockTableView captureArgument:@selector(setDelegate:) atIndex:0];
				sut = [[DefinedTableManager alloc] initWithTableView:mockTableView];
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

		});
	});

SPEC_END