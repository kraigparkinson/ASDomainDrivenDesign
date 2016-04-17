(*!
	@header Test ASDomainDrivenDesign
		ASDomainDrivenDesign self tests.
	@abstract License: GNU GPL, see COPYING for details.
	@author Kraig Parkinson
	@copyright 2015 kraigparkinson
*)

property ddd : script "com.kraigparkinson/ASDomainDrivenDesign"

property parent : script "com.lifepillar/ASUnit"
property suite : makeTestSuite("ASDomainDrivenDesign")

my autorun(suite)

script |ASDomainDrivenDesign|
	property parent : TestSet(me)
	
	on setUp()
	end setUp
	
	on tearDown()
	end tearDown
	
	script |And Specification|
		property parent : UnitTest(me)

		tell ddd
			my assert(my trueSpec()'s andSpec(my trueSpec())'s isSatisfiedBy(missing value), "true and true")
			my refute(my trueSpec()'s andSpec(my falseSpec())'s isSatisfiedBy(missing value), "true and false")
			my refute(my falseSpec()'s andSpec(my trueSpec())'s isSatisfiedBy(missing value), "false and true")
			my refute(my falseSpec()'s andSpec(my falseSpec())'s isSatisfiedBy(missing value), "false and false")
		end tell		
	end script

	script |Or Specification|
		property parent : UnitTest(me)
		
		tell ddd
			my assert(my trueSpec()'s orSpec(my trueSpec())'s isSatisfiedBy(missing value), "true and true")
			my assert(my trueSpec()'s orSpec(my falseSpec())'s isSatisfiedBy(missing value), "true and false")
			my assert(my falseSpec()'s orSpec(my trueSpec())'s isSatisfiedBy(missing value), "false and true")
			my refute(my falseSpec()'s orSpec(my falseSpec())'s isSatisfiedBy(missing value), "false and false")
		end tell
	end script

	script |Not Specification|
		property parent : UnitTest(me)
		
		tell ddd
			my refute(my trueSpec()'s notSpec()'s isSatisfiedBy(missing value), "false")
			my assert(my falseSpec()'s notSpec()'s isSatisfiedBy(missing value), "true")
		end tell
	end script

	
	on trueSpec()
		script TrueSpecification
			property parent : ddd's AbstractSpecification 
			on isSatisfiedBy(object)
				return true
			end isSatisfiedBy
		end script
		return TrueSpecification
	end trueSpec
	
	on falseSpec()
		script FalseSpecification
			property parent : ddd's AbstractSpecification
			on isSatisfiedBy(object)
				return false
			end isSatisfiedBy
		end script
		return FalseSpecification
	end falseSpec
end script
