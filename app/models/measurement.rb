# == Schema Information
#
# Table name: measurements
#
#  id          :integer          not null, primary key
#  value       :float
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  recorded_at :datetime
#

class Measurement < ActiveRecord::Base
  attr_accessible :value, :recorded_at

  belongs_to :user

  validates :value, :presence => true, :numericality => true
  validates :recorded_at, :presence => true

  # Necessary to build out the select_options class
  ## ActiveRecord uses ActiveSupport’s DescendantsTracker module (versions prior to
  ## Rails 3 use a class variable @@subclasses which is accessible only through the
  ## protected method subclasses).
  # http://www.alexreisner.com/code/single-table-inheritance-in-rails
  # @child_classes = []

  # def self.inherited(child)
  #   @child_classes << child
  #   super # important!
  # end

  # def self.child_classes
  #   @child_classes
  # end

  # def self.select_options
  #   descendants.map{ |c| c.to_s }.sort
  # end

  def self.current
    order("recorded_at DESC").first
  end
end
