require './lib/hand'
require 'colorize'

class Solver
    attr_reader :verbose, :filepath, :result

    def initialize(params = {})
        @verbose = params[:verbose] || true
        @filepath = params[:file] || './poker.txt'
        @file = nil
        @result = { player_one: 0, player_two: 0 }
        
    end

    def load
        @file = IO.new(IO.sysopen(filepath, 'r+'))
    end

    def solve
        line = @file.gets
        line = line.split(' ')
        p1 = Hand.new(line.slice!(0, 5).join(' '))
        p2 = Hand.new(line.join(' '))
        
        if p1 > p2
            result[:player_one] += 1
            print '+'.green if verbose
        else
            result[:player_two] += 1
            print '-'.red if verbose
        end
    end

    def solve_all
        counter = 0
        while !@file.eof?
            solve
            counter += 1
        end
        print "\nCompleted. Processed #{counter} sets of two hands. Player 1 score is #{result[:player_one]}\n"
    end

end
