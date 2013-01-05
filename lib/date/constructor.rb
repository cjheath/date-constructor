require 'date'

# Allow a Date to be constructed from any Date or DateTime subclass, or parsed from a String
class ::Date

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

  if defined?(RUBY_ENGINE) and RUBY_ENGINE == 'ruby'	  # RUBY >= 1.9
    # If someone calls allocate/initialize, make that work
    # ... just don't mess up DateTime which is a subclass of Date
    def initialize *a, &b
      unless self.is_a?(DateTime)
	constructed = self.class.new(*a, &b)
	dumped = constructed.marshal_dump
	marshal_load(dumped)
      end
    end
  end
end

# Allow a DateTime to be constructed from any Date or DateTime subclass, or parsed from a String
class ::DateTime

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

  if defined?(RUBY_ENGINE) and RUBY_ENGINE == 'ruby'	  # RUBY >= 1.9
    def initialize *a, &b
      marshal_load(self.class.new(*a, &b).marshal_dump)
    end
  end
end
