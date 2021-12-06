require "../lantern_fish_school.rb"

DAYS_TO_CYCLE = 80

starting_school = File.readlines("../data.txt", ",", chomp: true).map(&:to_i)
lanter_fish_school = LanternFishSchool.new(starting_school)

puts lanter_fish_school.cycle(DAYS_TO_CYCLE).size