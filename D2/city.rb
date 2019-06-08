# class for the cities in the map
class City
  attr_reader :name, :cities, :mg, :ms, :prng
  def initialize(name, maxg, maxs, prng)
    @name = name
    @cities = nil
    @mg = maxg
    @ms = maxs
    @prng = prng
  end

  def link_neighbors(cities)
    return nil unless cities.is_a? Array

    @cities = cities
  end

  def next
    return nil if @cities.nil?

    nc = @prng.rand(0..@cities.length - 1)
    @cities[nc]
  end

  def prospect_gold
    @prng.rand(0..@mg)
  end

  def prospect_silver
    @prng.rand(0..@ms)
  end
end
