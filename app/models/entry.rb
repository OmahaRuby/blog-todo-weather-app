class Entry < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  
  before_create :set_temperature_when_created
  before_save :set_temperature_when_completed
  
  private
  
  def set_temperature_when_created
    if self.temperature_when_created.nil?
      self.temperature_when_created = ForecastIO.forecast(41.2587361,-95.9304049, time: Time.now.to_i).currently.temperature
    end
  end
  
  def set_temperature_when_completed
    if self.temperature_when_completed.nil? && self.completed_at.present?
      self.temperature_when_completed = ForecastIO.forecast(41.2587361,-95.9304049, time: self.completed_at.to_i).currently.temperature
    end
  end
end
