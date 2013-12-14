#import "Kiwi.h"
#import "DefinedTaskItemSource.h"
#import "TaskItem.h"

SPEC_BEGIN(DefinedTaskItemSourceSpec)
	describe(@"Defined Task Item Source", ^{
		__block DefinedTaskItemSource *sut;

		beforeEach(^{
			sut = [[DefinedTaskItemSource alloc] init];
		});

		afterEach(^{
			sut = nil;
		});

		context(@"construction", ^{
			it(@"should conform to UITableViewDataSourceProtocol", ^{
				[[sut should] conformToProtocol:@protocol(UITableViewDataSource)];
			});
		});

		context(@"items", ^{
			it(@"should return 3 when asked for number of rows in section", ^{
				NSMutableArray *items = [NSMutableArray array];
				[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit"]];
				[sut setItems:items];
				[[theValue([sut tableView:nil numberOfRowsInSection:0]) should] equal:theValue(3)];
			});

		});
	});
SPEC_END