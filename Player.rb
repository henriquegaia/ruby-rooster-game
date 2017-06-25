class Player

	attr_accessor :name, :number

	def initialize(number, name='pc')
		@name = name
		@number = number
	end

	def toString
		puts "player #{number}: " + name
	end

end