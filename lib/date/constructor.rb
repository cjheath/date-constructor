require 'date'

# Allow a Date to be constructed from any Date or DateTime subclass, or parsed from a String
class ::Date
  # If someone calls allocate/initialize, make that work
  # ... just don't mess up DateTime which is a subclass of Date
  def initialize *a, &b
    marshal_load(self.class.new(*a, &b).marshal_dump) unless self.is_a?(DateTime)
  end

  def self.new *a, &b
    if a[0].is_a?(String)
      parse(*a)
    elsif (a.size == 1)
      case a[0]
      when DateTime
	civil(a[0].year, a[0].month, a[0].day, a[0].start)
      when Date
	a[0].clone
      else
	civil(*a, &b)
      end
    else
      civil(*a, &b)
    end
  end
end

# Allow a DateTime to be constructed from any Date or DateTime subclass, or parsed from a String
class ::DateTime
  def initialize *a, &b
    marshal_load(self.class.new(*a, &b).marshal_dump)
  end

  def self.new *a, &b
    if a[0].is_a?(String)
      parse(*a)
    elsif (a.size == 1)
      case a[0]
      when DateTime
	a[0].clone
      when Date
	civil(a[0].year, a[0].month, a[0].day, 0, 0, 0, a[0].start)
      else
	civil(*a, &b)
      end
    else
      civil(*a, &b)
    end
  end
end
