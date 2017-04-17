class Hand
    include Comparable
    attr_reader :numbers, :suits, :counts, :score, :sum
    
    def initialize(values)
        @numbers = values
                    .split(' ')
                    .map { |val| val.split('')[0] }

        @suits = values  
                    .split(' ')
                    .map { |val| val.split('')[1] }
   
        @counts = card_counts(numbers)
        @sum = card_sum
        @score = hand_score 
    end
    
    def <=>(other)
        if (!score && !other.score) || (score == other.score)
            return sum <=> other.sum
        end
        score <=> other.score
    end

    def hand_score
        case
        when royal_flush?
            return 9
        when straight_flush?
            return 8
        when four_of_a_kind?
            return 7
        when full_house?
            return 6
        when flush?
            return 5
        when straight?
            return 4
        when three_of_a_kind?
            return 3
        when two_pair?
            return 2
        when one_pair?
            return 1
        else
            return 0
        end
        
    end

    def one_pair?
        counts[:pairs] == 1
    end
    
    def two_pair?
        counts[:pairs] == 2
    end
    
    def three_of_a_kind?
        counts[:three_of_a_kind] == 1 && counts[:pairs] === 0
    end
  
    def straight?
        consecutive?(numbers)
    end

    def flush?
        equal_values?(suits)
    end

    def full_house?
        three_of_a_kind? && one_pair?
    end

    def four_of_a_kind?
        counts[:four_of_a_kind] == 1 
    end
   
    def straight_flush?
        straight? && flush? 
    end

    def royal_flush?
        (["T", "J", "K", "Q", "A"] == numbers) && flush?
    end
    
    private
    def deck
        "23456789TJQKA".split('')
    end

    def consecutive?(ary)
        previous = nil
        result = true
        ary.each do |val|
            val = deck.index(val)
            break if !result
            previous ||= val - 1
            result = false if val != previous + 1
            previous = val
        end
        result
    end
    def card_sum
        numbers.reduce { |acc, val| acc.to_i + (deck.index(val).to_i + 1) } # zero-based index
    end
    
    def equal_values?(ary)
        ary.all? { |val| val == ary.first }
    end
    
    def card_counts(ary)
        values = {}
        result = { pairs: 0, three_of_a_kind: 0, four_of_a_kind: 0 }
        ary.each do |val|
            values[val] ||= 0
            values[val] += 1  
        end
        values.each_value do |val|
            case val
            when 2
                result[:pairs] += 1
            when 3
                result[:three_of_a_kind] += 1
            when 4
                result[:four_of_a_kind] += 1
            end
        end
        result
    end
end
