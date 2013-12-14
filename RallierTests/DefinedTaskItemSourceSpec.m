#import "Kiwi.h"
#import "DefinedTaskItemSource.h"

SPEC_BEGIN(DefinedTaskItemSourceSpec)
	describe(@"Defined Task Item Source", ^{
		__block DefinedTaskItemSource *sut;

		afterEach(^{
			sut = nil;
		});

		context(@"construction", ^{
			it(@"should conform to UITableViewDataSourceProtocol", ^{
				sut = [[DefinedTaskItemSource alloc] init];
				[[sut should] conformToProtocol:@protocol(UITableViewDataSource)];
			});
		});
	});
SPEC_END