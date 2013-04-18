class Unit

  # inspired by http://stackoverflow.com/a/15269518

  @@conversion_rates = {
    meters: {
      feet: 3.28084,
      meters: 1.0,
      centimeters: 100
    },

    centimeters: {
      meters: 0.01
    }
  }

  def initialize(length, unit)
    @length = length
    @unit = unit
  end

  def to(new_unit)
    new_length = @length * @@conversion_rates[@unit][new_unit]
  end

end
