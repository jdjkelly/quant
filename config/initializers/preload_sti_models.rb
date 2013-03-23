if Rails.env.development?
  %w[measurements/fat_mass measurements/fat_percentage measurements/lean_mass measurements/weight].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end
