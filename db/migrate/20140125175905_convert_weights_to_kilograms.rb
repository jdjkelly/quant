class ConvertWeightsToKilograms < ActiveRecord::Migration
  def up
    Weight.all.each do |weight|
      weight.update_attribute(:value, Unit.new(weight.value, :pounds).to_system(:metric))
    end
  end
end
