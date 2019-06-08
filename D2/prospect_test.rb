require 'minitest/autorun'
require_relative 'prospect.rb'

class GoldRushTest < Minitest::Test

	def setup
    	@p = Prospect.new(0)
  	end

	# UNIT TESTS FOR METHOD initialize(seed)
	# Equivalence classes:
	# Tests that the object is made correctly.
	def test_initialize
	  assert_equal @p.days, 0
	  assert_equal @p.numloc, 0
	  assert_equal @p.totg, 0
	  assert_equal @p.tots, 0
	end
	# UNIT TESTS FOR METHOD initialize_map(seed)
	# Equivalence classes:
	# map is made correctly
	def test_initialize_map
		assert_equal @p.loc.name, 'Sutter Creek'
	end
	
	# UNIT TESTS FOR METHOD check_args(args)
	# Equivalence classes:
	# two arguments valid
	# two arguments but negative second number
	# not two arguments
	# If two valid numbers are passed in the program will proceed.
	def test_check_args_valid
		args = Prospect.new(0)
		assert_silent {args.check_args [1, 2]}
	end
	# If a negative second argument is passed usage will be called.
	# EDGE CASE
	def test_check_args_negative
		args = Prospect.new(0)
		def args.show_usage
		  10
        end
		check = args.check_args [1, -1]
		assert_equal check, 10
	end
	# If an incorrect number of arguments is used usage will be called.
	# EDGE CASE
	def test_check_args_wrong
		args = Prospect.new(0)
		def args.show_usage
		  10
        end
		check = args.check_args [1]
		assert_equal check, 10
	end
	# UNIT TESTS FOR METHOD move
	# Equivalence classes:
	# 1 gold, 1 silver
	# 1 gold, non-1 silver 
	# non-1 gold, 1 silver
	# If the total gold and silver amount to one each, display the proper text. 
	def test_move_one_each
		@p.totg = 1
		@p.tots = 1
		assert_output(/Heading from Sutter Creek to Angels Camp, holding 1 ounce of gold and 1 ounce of silver./) {@p.move}
	end
	# If the total gold is 1, but the total silver is not, display the proper text. 
	def test_move_non_one_silver
		 @p.totg = 1
		 @p.tots = 9 
		 assert_output(/Heading from Sutter Creek to Angels Camp, holding 1 ounce of gold and 9 ounces of silver./) {@p.move}
	end
	# If the total silver is 1, but the total gold is not, display the proper text. 
	def test_move_non_one_gold
		 @p.totg = 14
		 @p.tots = 1
		 assert_output(/Heading from Sutter Creek to Angels Camp, holding 14 ounces of gold and 1 ounce of silver./) {@p.move}
	end
	# UNIT TESTS FOR METHOD print_found
	# Equivalence classes:
	# move zero minerals found
	# move 4 or 5 city
	# no move
	# If zero minerals of both types were found, then the total mineral amounts will stay the same. The location number will increase.
	def test_print_found_move_zero
	   temps = @p.tots
	   tempg = @p.totg
	   temploc = @p.numloc
	   @p.print_found(0,0)
	   assert_equal @p.tots, temps
	   assert_equal @p.totg, tempg
	   assert_equal @p.numloc, temploc + 1
	end
	# If minerals are found within bounds of 1 and 2 (respectively), then the total mineral amounts will adjust accordingly. The location number will increase.
	def test_print_found_move_lasttwo
		@p.numloc = 4
		@p.print_found(1,2)
		assert_equal @p.totg, 1 
		assert_equal @p.tots, 2
		assert_equal @p.numloc, 5 
	end
	# If minerals are found past bounds of 1 and 2 (respectively), then the total mineral amounts will adjust accordingly. The location number will stay the same if location is = 5.
	def test_print_found_move_stay
		@p.numloc = 5 
		@p.print_found(3,4)
		assert_equal @p.totg, 3
		assert_equal @p.tots, 4
		assert_equal @p.numloc, 5
	end
	
	# UNIT TESTS FOR METHOD print_gold
	# Equivalence classes:
	# zero found
	# 1 found
	# more than 1 found
	# If 0 is passed in as newg, then "Found 0 ounces of gold" is printed. 
	def test_print_gold_zero
	  assert_output(//) {@p.print_gold(0)}
	end
	# If 1 is passed in as newg, then "Found 1 ounce of gold" is printed. 
	def test_print_gold_one
	  assert_output(/Found 1 ounce of gold/) {@p.print_gold(1)}
	end
	# If a number greater than 1 is passed in as newg, then "Found newg ounces of gold" is printed. 
	def test_print_gold_positive
	  assert_output(/Found 6 ounces of gold/) {@p.print_gold(6)}
	end
	# UNIT TESTS FOR METHOD print-silver
	# Equivalence classes:
	# zero found (no gold)
	# one found (no gold)
	# more than one found (no gold)
	# zero found
	# one found 
	# more than one found 
	# If both arguments passed are zero, then "Found no precious metals in Sutter Creek." is printed. 
	def test_print_silver_zero
		assert_output(/Found no precious metals in Sutter Creek./) {@p.print_silver(0, 0)}
	end
	# If 0 is passed as newg and 1 is passed as news, then "Found one ounce of silver in Sutter Creek." is printed. 
	def test_print_silver_one
		assert_output(/1 ounce of silver in Sutter Creek./) {@p.print_silver(0, 1)}
	end
	# If 0 is passed as newg and a number greater than 1 is passed as news, then "Found news ounces of silver in Sutter Creek." is printed.
	def test_print_silver_positive
		assert_output(/6 ounces of silver in Sutter Creek./) {@p.print_silver(0, 6)}
	end
	# If a positive number is passed as newg and 0 is passed as news, then " in Sutter Creek." is printed. 
	def test_print_silver_zero_silver
		assert_output(/ in Sutter Creek./) {@p.print_silver(5, 0)}
	end
	# If a positive number is passed as newg and 1 is passed as news, then "1 ounce of silver in Sutter Creek." is printed. 
	def test_print_silver_one_silver
		assert_output(/1 ounce of silver in Sutter Creek./) {@p.print_silver(4, 1)}
	end
	# If a positive number is passed as newg and a number greater than 1 is passed as new, then "news ounces of silver in Sutter Creek." is printed.
	def test_print_silver_positive_silver
		assert_output(/8 ounces of silver in Sutter Creek./) {@p.print_silver(3, 8)}
	end
	# UNIT TESTS FOR METHOD simulate
	# Equivalence classes:
	# one prospect
	# more than one prospect  
    def test_simulate_one
		@p.days = 5 
		@p.numloc = 5
		@p.totg = 9
		@p.tots = 7
		assert_output("Prospector 1 starting in Sutter Creek.\nAfter 5 days, Prospector 1 returned to San Francisco with:\n \t\t9 ounces of gold.\n \t\t7 ounces of silver.\n \t\tHeading home with $195.2.\n") {@p.simulate(1)}
	end
	 
end
