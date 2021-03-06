(*! @abstract <em>[text]</em> OmniFocusLibrary's name. *)
property name : "ASDomainDrivenDesign"
(*! @abstract <em>[text]</em> OmniFocusLibrary's version. *)
property version : "1.0.0"
(*! @abstract <em>[text]</em> OmniFocusLibrary's id. *)
property id : "com.kraigparkinson.ASDomainDrivenDesign"


script Specification 
	property class : "Specification"
	
	on isSatisfiedBy(candidate)
		return true
	end isSatisfiedBy
	
	on andSpec(other)
	end andSpec
	
	on orSpec(other)
	end orSpec
	
	on notSpec()
	end notSpec
end script --Specification

script DefaultSpecification
	property parent : Specification
	property class : "DefaultSpecification"
	
	on andSpec(other)	
		return makeAndSpecification(me, other)
	end andSpec

	on orSpec(other)	
		return makeOrSpecification(me, other)
	end orSpec
	
	on notSpec()
		return makeNotSpecification(me)
	end notSpec
	
end script

on makeAndSpecification(one, other)
	script AndSpecification
		property parent : DefaultSpecification
		property class : "AndSpecification"
		property oneSpec : one
		property otherSpec : other
		property name : "(" & one's name & space & "and" & space & other's name & ")"
	
		on isSatisfiedBy(candidate)
			set satisfiedByResult to oneSpec's isSatisfiedBy(candidate)
			if (satisfiedByResult)
				return otherSpec's isSatisfiedBy(candidate)
			else
				return false
			end if 
		end isSatisfiedBy
	end script
	return AndSpecification
end makeOrSpecification

on makeOrSpecification(one, other)
	script OrSpecification
		property parent : DefaultSpecification
		property class : "OrSpecification"
		property oneSpec : one
		property otherSpec : other
		property name : "(" & one's name & space & "or" & space & other's name & ")"
		
		on isSatisfiedBy(candidate)
		
			return oneSpec's isSatisfiedBy(candidate) or otherSpec's isSatisfiedBy(candidate)
		end isSatisfiedBy
	end script
	return OrSpecification
end makeOrSpecification

on makeNotSpecification(wrapped)
	script NotSpecification
		property parent : DefaultSpecification
		property class : "NotSpecification"
		property wrappedSpec : wrapped
		property name : "not (" & wrapped's name & ")"
	
	
		on isSatisfiedBy(candidate)		
			return not wrappedSpec's isSatisfiedBy(candidate)
		end isSatisfiedBy
	end script
	return NotSpecification
end makeNotSpecification
