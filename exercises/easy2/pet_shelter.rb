
class Pet
  attr_reader :type, :pet_name

  def initialize(type, pet_name)
    @type = type
    @pet_name = pet_name
  end

  def to_s
    "a #{type} named #{pet_name}"
  end
end

class Owner
  attr_accessor :name, :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end


class Shelter
  attr_reader :records

  def initialize
    @records = Hash.new
  end

  def adopt(owner, pet)
    if records.keys.include?(owner)
      records[owner] << pet
    else
      records[owner] = [pet]
    end

    owner.number_of_pets += 1
  end

  def print_adoptions
    records.each_pair do |owner, pet|
      puts "#{owner.name} has adopted the following pets:"
      pet.each { |pet| puts pet}
      puts ""
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."