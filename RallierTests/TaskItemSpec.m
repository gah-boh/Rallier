#import "Kiwi.h"
#import "TaskItem.h"

SPEC_BEGIN(TaskItemSpec)

describe(@"TaskItem", ^{
	__block TaskItem *stu;
	
	beforeEach(^{
		stu = [[TaskItem alloc] initWithName:@"Testing" estimate:@0 toDo:@0];
	});

	it(@"should initialize with name", ^{
		[[[stu taskName] should] equal:@"Testing"];
	});

	it(@"estimate property should not be nil", ^{
		[[stu estimate] shouldNotBeNil];
	});

});

SPEC_END