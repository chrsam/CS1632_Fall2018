require_relative 'city.rb'
require_relative 'prospect.rb'

run = Prospect.new ARGV[0]
run.check_args ARGV
run.simulate ARGV[1].to_i
