require_relative 'city.rb'

# class to run simulation of prospecting
class Prospect
  attr_accessor :days, :numloc, :loc, :totg, :tots
  def initialize(seed)
    @days = 0
    @numloc = 0
    @totg = 0
    @tots = 0
    @loc = initialize_map(seed)
  end

  def initialize_map(seed)
    prng = Random.new(seed.to_i)
    nevadacity = City.new('Nevada City', 5, 0, prng)
    angelscamp = City.new('Angels Camp', 4, 0, prng)
    suttercreek = City.new('Sutter Creek', 2, 0, prng)
    virginiacity = City.new('Virginia City', 3, 3, prng)
    coloma = City.new('Coloma', 3, 0, prng)
    midas = City.new('Midas', 0, 5, prng)
    eldoradocanyon = City.new('El Dorado Canyon', 0, 10, prng)
    nevadacity.link_neighbors [angelscamp]
    angelscamp.link_neighbors [nevadacity, virginiacity, suttercreek]
    suttercreek.link_neighbors [angelscamp, coloma]
    coloma.link_neighbors [suttercreek, virginiacity]
    virginiacity.link_neighbors [coloma, angelscamp, midas, eldoradocanyon]
    midas.link_neighbors [virginiacity, eldoradocanyon]
    eldoradocanyon.link_neighbors [virginiacity, midas]
    suttercreek
  end

  def show_usage
    puts 'Usage:'
    puts 'ruby gold_rush.rb *x* *y*'
    puts '*x* should be an integer *y* should be a nonnegative integer'
    exit 1
  end

  def check_args(args)
    args.count == 2 && args[1].to_i > 0
    show_usage if args.size != 2 || args[1].to_i <= 0
  rescue StandardError
    false
  end

  def move
    print"Heading from #{@loc.name} to "
    @loc = @loc.next
    print "#{@loc.name}, holding #{@totg}"
    if @totg == 1
      print ' ounce of gold and '
    else
      print ' ounces of gold and '
    end
    print "#{@tots} "
    if @tots == 1
      puts 'ounce of silver.'
    else
      puts 'ounces of silver.'
    end
  end

  def print_gold(newg)
    if newg == 1
      print "		Found #{newg} ounce of gold"
    elsif newg > 1
      print "		Found #{newg} ounces of gold"
    end
  end

  def print_silver(newg, news)
    if news.zero? && newg.zero?
      puts "		Found no precious metals in #{@loc.name}."
    elsif newg.zero?
      print '		Found '
    else
      print ' and '
    end
    if news == 1
      puts "#{news} ounce of silver in #{@loc.name}."
    elsif news > 1
      puts "#{news} ounces of silver in #{@loc.name}."
    elsif !newg.zero?
      puts " in #{@loc.name}."
    end
  end

  def print_found(newg, news)
    print_gold(newg)
    print_silver(newg, news)
    if newg.zero? && news.zero? || @numloc > 3 && newg <= 1 && news <= 2
      @numloc += 1
      move unless @numloc == 5
    end
    @totg += newg
    @tots += news
  end

  def simulate(nump)
    nump.times do |x|
      y = x + 1
      puts "Prospector #{y} starting in #{@loc.name}."
      until @numloc == 5
        newg = 1
        news = 1
        while newg != 0 && news != 0
          newg = @loc.prospect_gold
          news = @loc.prospect_silver
          @days += 1
          print_found(newg, news)
        end
      end
      puts "After #{@days} days, Prospector #{y} returned to San Francisco with:"
      puts " 		#{@totg} ounces of gold."
      puts " 		#{@tots} ounces of silver."
      print ' 		Heading home with $'
      Float money = (@totg * 20.67) + (@tots * 1.31)
      print money.round(2)
      puts '.'
    end
  end
end
