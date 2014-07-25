module Users
  module Weights

    def current_weight opts={}
      self.weights.current(:value, opts)
    end

    alias_method :weight, :current_weight

    def fat_mass opts={}
      self.weights.current(:fat_mass, opts)
    end

    def fat_percent opts={}
      self.weights.current(:fat_percent, opts)
    end

    def lean_mass opts={}
      self.weights.current(:lean_mass, opts)
    end

    def lean_mass_percentage
      lean_mass / weight * 100
    end

    def bmi opts={}
      self.weights.current(:bmi, opts)
    end

    protected

    def update_weights_bmi
      Weight.update_bmi_for_user(id)
    end
  end
end
