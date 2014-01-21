class Unit

  # inspired by http://stackoverflow.com/a/15269518

  @@conversion_rates = {
    meters: {
      feet: 3.28084,
      meters: 1.0,
      centimeters: 100,
      kilograms: 1.0
    },
    centimeters: {
      meters: 0.01
    },
    kilograms: {
      pounds: 2.2046
    },
    pounds: {
      kilograms: 0.453592,
      pounds: 1.0
    }
  }

  def initialize(length, unit)
    @length = length
    @unit = unit
  end

  def to(new_unit)
    return @length if @unit == new_unit

    new_length = @length * @@conversion_rates[@unit][new_unit]
  end

end
