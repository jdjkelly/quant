module MealsHelper
  def macro_percent_for_meals meals, macro
    sum = 0
    Meal::MACRO_NUTRIENTS.each do |macro|
      sum += meals.to_a.sum(&macro.to_sym)
    end
    meals.to_a.sum(&macro.to_sym).to_f / sum.to_f * 100
  end
end
