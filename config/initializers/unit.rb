class Unit

  # inspired by http://stackoverflow.com/a/15269518

  SYSTEMS = [:metric, :imperial]

  IMPERIAL = %w(:inches :feet :miles :pounds)

  METRIC = %w(:centimeters :meters :kilometers :kilograms)

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
    },
    feet: {
      inches: 12.0,
      meters: 0.3048,
      feet: 1.0
    }
  }

  @@conversion_types = {
    metric: {
      inches: :centimeters,
      feet: :meters,
      miles: :kilometers,
      pounds: :kilograms
    },
    imperial: {
      centimeters: :inches,
      meters: :feet,
      kilometers: :miles,
      kilograms: :pounds
    },
    centimeters: :metric,
    meters: :metric,
    kilometers: :metric,
    kilograms: :metric,
    inches: :imperial,
    feet: :imperial,
    miles: :imperial,
    pounds: :imperial
  }

  def initialize(length, unit)
    @length = length
    @unit = unit
    @system = system
  end

  def to_unit(new_unit)
    return @length if @unit == new_unit

    @length * @@conversion_rates[@unit][new_unit]
  end

  def to_system(new_system)
    return @length if @system == new_system

    unit = @@conversion_types[new_system][@unit]

    to_unit(unit)
  end

  def system
    @@conversion_types[@unit]
  end

end
