## Euler-54

Solution to [Euler Problem #54](https://projecteuler.net/problem=54) in Ruby.


### Requirements

- Ruby 2.4


### Installing
- `git clone https://github.com/heyts/euler-54`
- `cd euler-54`
- `bundle install`
- `rake solve`


### Problem logical decomposition
- Load the content of the file line-by-line using the IO class
- Split line into two hands & Hand class instantion for each Hand
- Each hand is made of 5 instances of the Card Class
- Each Hand can be compared to another Hand
- While there are lines in the file, compare each two hands and determine the winner ; increment the variables accordingly
- Display the number of hands that the player 1 when all lines of the file have been parsed
