require 'matrix'

	########################################################

class Matrix

	def []=(i, j, x)
		@rows[i][j] = x
	end

end

	########################################################
class Board

	attr_accessor :matrix, :rows, :cols

	########################################################

	def initialize
		@rows = 3
		@cols = 3
		@matrix = Matrix.zero(@rows)
	end

	########################################################

	def printMatrix
		columnCount = 0
		puts ""
		printColIdentifier()
		printMatrixContent(columnCount)
		puts ""
	end

	#####################################################

	def numberOfSpotsAvailable
		count=0
		@matrix.each_with_index do |value|
			if value == 0
				count += 1
			end
		end
		return count
	end

	#####################################################

	def spotsAvailable

		available = []
		columnCount = 0
		
		@matrix.each_with_index do |value, row, column|
			
			columnCount += 1

			rowChar = ("a".ord + row).chr
			cell = rowChar + columnCount.to_s

			if columnCount == @cols
				columnCount = 0
			end

			if value == 0
				available.push(cell.to_s)
			end

		end
		
		return available
	end	

	#####################################################
	
	def addMove(lastMove, lastPlayer)
		lastMoveParts = lastMove.chars.to_a
		row = lastMoveParts[0]
		row = rowToInt(row)
		col = lastMoveParts[1].to_i - 1
		@matrix[row, col] = lastPlayer.to_s
	end



	#####################################################

	def hasSpotsAvailable
		return numberOfSpotsAvailable != 0
	end

	#####################################################
	
	def hasVerticalSequence
		matrixTransposed = @matrix.transpose
		return hasHorizontalSequence(matrixTransposed)
	end

	#####################################################

	def hasHorizontalSequence(matrix = @matrix)
		foundEqual = 0
		matrix.each_with_index do |value, row, column|

			# increment couter
			if value != 0 && value == matrix[row, 0]
				foundEqual += 1
			end

			# return if all rows have same value
			if @cols == foundEqual
				return true
			end

			# if column = 2, put counter to zero
			if column == @cols - 1
				foundEqual = 0
			end
			
		end
		return false
	end

	#####################################################

	def hasDiagonalSequence
		
		return hasStraigthDiagonalSequence() ||
			hasReverseDiagonalSequence()
	end

	#####################################################

	def hasStraigthDiagonalSequence

		refValue = @matrix[0,0]

		if refValue == 0
			return false
		end

		@rows.times do |n|
			if @matrix[n, n] != refValue
				return false
			end
		end

		return true
	end

	#####################################################

	def hasReverseDiagonalSequence

		if @matrix[1,1] == 0
			return false
		end

		result =  ( @matrix[0,2] == @matrix[1,1] ) &&
				( @matrix[1,1] == @matrix[2,0] )

		if !result 
			return false
		else
			return true
		end	

		<<-doc 
		BUG: NEVER RETURNING TRUE 

		refValue = @matrix[@rows - 1, 0]

		if refValue == 0
			return false
		end

		counter = 0		
		@rows.times do |n|

			col = @cols - counter

			if @matrix[n, col] != refValue
				return false
			end

			counter += 1			
		end

		return true
		doc
	end

	#####################################################
	
	def getRandomAvailableSpot
		spotsAvailable = spotsAvailable()
		return spotsAvailable[rand(spotsAvailable.size())]
	end

	#####################################################
	#####################################################
	private 
	#####################################################
	#####################################################

		def rowToInt(row)
			return row.ord - 97
		end

		def printRowIdentifier(columnCount, row)
			if(columnCount == 1)
				rowChar = ("a".ord + row).chr
				print rowChar.to_s.ljust(5)
			end
		end

	#####################################################

		def printColIdentifier
			print "".to_s.ljust(5)
			i = 1
			while ( i <= @cols)
				print i.to_s.ljust(5)
				i += 1
			end
			puts ""
			puts ""
		end

	#####################################################

		def printMatrixContent(columnCount)

			@matrix.each_with_index do |value, row, column|
			
				columnCount += 1

				printRowIdentifier(columnCount, row)
				
				print value.to_s.ljust(5)

				if columnCount == @cols
					puts ""
					columnCount = 0
				end

			end
		end

	#####################################################
end