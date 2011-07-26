class Person < ActiveResource::Base
  self.site = "http://api.people.com/"
end

@person = Person.find(1)
# GET http://api.people.com/people/1

@person.age = 43
@person.save
# UPDATE http://api.people.com/people/1
#        { age: 43 }

