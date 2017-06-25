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
		#@matrix[1,1]="p1"
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
		return false
	end

	#####################################################

	def hasHorizontalSequence
		return true
		@matrix.each_with_index do |value, row, column|

			puts column
			
		end
	end

	#####################################################

	def hasDiagonalSequence
		return false
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