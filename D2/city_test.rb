require 'minitest/autorun'
require_relative 'city.rb'

class GoldRushTest < Minitest::Test
	# UNIT TESTS FOR METHOD initialize(name, maxg, maxs)
	# Equivalence classes:
	# SUCESS CASES: all variables are valid
	# FAILURE CASES: If any value is not of the right type. 
	# Tests that the values are initiated correctly.
	def test_initialize
	  prng = Minitest::Mock.new
	  def prng.rand(num); 0; end
	  city = City.new("Fake City", 0, 0, prng)
	  assert_equal city.name, "Fake City" 
	  assert city.mg, 0 
	  assert city.ms, 0
	end
	# UNIT TESTS FOR METHOD link_neighbors(neigh1, neigh2, neigh3, neigh4)
	# Equivalence classes:
	# nil
	# valid array
	# If a valid array is passed in the cities array is set to be this array.
	def test_link_neighbors_valid
	    prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 7, 0, prng)
		city1 = City.new("Fake City 1", 7, 0, prng)
		city2 = City.new("Fake City 2", 7, 0, prng)
		Array cities = [city1, city2]
		city.link_neighbors cities
		assert_equal cities, city.cities
	end
	# If nil is passed in then the array is nil.
	def test_link_neighbors_nil
		prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 7, 0, prng)
		assert_nil city.cities
	end
	# If a non array is passed in the array is nil.
	# EDGE CASE
	def test_link_neighbors_invalid
	  prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 7, 0, prng)
		city.link_neighbors 'here'
		assert_nil city.cities
	end
	# UNIT TESTS FOR METHOD next
	# Equivalence classes:
	# no neighbors 
	# positive number of neighbors
	# If there a city has no neighbors nil is returned.
	# EDGE CASE
	def test_next_nil
	    prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 7, 0, prng)
		city = city.next
		assert_nil city
	end
	#If a city has neighbors a valid one is returned
	def test_next_valid
	    prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 7, 0, prng)
		city1 = City.new("Fake City 1", 7, 0, prng)
		city2 = City.new("Fake City 2", 7, 0, prng)
		city.link_neighbors [city1, city2]
		city = city.next
		assert_includes [city1, city2], city
	end
	
	# UNIT TESTS FOR METHOD prospect_gold
	# Equivalence classes:
	# max gold is positive
	# max gold is zero
	# A valid number in the range between 0 and max gold is returned.
	def test_prospect_gold_positive
	    prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 7, 0, prng)
		check = city.prospect_gold
		assert_includes (0..7), check
	end
	# If max gold is zero, zero is returned.
	# EDGE CASE
	def test_prospect_gold_zero
		prng = Minitest::Mock.new
	    def prng.rand(num); 0; end
		city = City.new("Fake City", 0, 0, prng)
		check = city.prospect_gold
		assert_equal 0, check
	end
	
	# UNIT TESTS FOR METHOD prospect_silver
	# Equivalence classes:
	# max silver is positve
	# max silver is zero
	# A valid number is returned in the range between zero and max silver.
	def test_prospect_silver_positive
	    prng = Minitest::Mock.new
	    def prng.rand(num); 1; end
		city = City.new("Fake City", 0, 7, prng)
		check = city.prospect_silver
		assert_includes (0..7), check
	end
	# If max silver is zero, zero is returned.
	# EDGE CASE
	def test_prospect_silver_zero
		prng = Minitest::Mock.new
	    def prng.rand(num); 0; end
		city = City.new("Fake City", 0, 0, prng)
		check = city.prospect_gold
		assert_equal 0, check
	end
	
end
