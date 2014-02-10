module Users
  module Weights

    def current_weight
      self.weights.current
    end

    def weight
      return unless current_weight
      current_weight.value
    end

    def fat_mass
      return unless current_weight
      current_weight.fat_mass
    end

    def fat_percent
      return unless current_weight
      current_weight.fat_percent
    end

    def lean_mass
      return unless current_weight
      current_weight.lean_mass
    end

    def lean_mass_percentage
      return unless current_weight
      current_weight.lean_mass / weight * 100
    end

    def bmi
      return unless current_weight
      current_weight.bmi
    end

  protected

    def update_weights_bmi
      Weight.update_bmi_for_user(id)
    end
  end
end
