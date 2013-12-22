#import "Kiwi.h"
#import "TaskItem.h"

SPEC_BEGIN(TaskItemSpec)

describe(@"TaskItem", ^{
	__block TaskItem *stu;
	
	beforeEach(^{
		stu = [[TaskItem alloc] initWithName:@"Testing"];
	});

	it(@"should initialize with name", ^{
		[[[stu taskName] should] equal:@"Testing"];
	});

});

SPEC_END