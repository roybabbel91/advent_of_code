class LanternFishSchool
  NEW_FISH_OFFSET = 2
  CYCLE_SIZE = 6

  def initialize(school)
    self.school = Hash.new(0).tap { |h| school.each { |v| h[v] += 1 } }
  end

  def cycle(v)
    (1..v).each do |_|
      self.school = (0..max_cycles).each_with_object(Hash.new(0)) do |cadence_group, new_school|
        if cadence_group == 0
          new_school[max_cycles] += school[cadence_group]
          new_school[CYCLE_SIZE] += school[cadence_group]
        else
          new_school[cadence_group - 1] += school[cadence_group]
        end
      end
    end
    self
  end

  def size
    school.values.sum
  end

  private

  attr_accessor :school

  def max_cycles
    NEW_FISH_OFFSET + CYCLE_SIZE
  end
end
