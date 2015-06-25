class AddTemperatureWhenCreatedAndTemperatureWhenCompletedToItems < ActiveRecord::Migration
  class Item < ActiveRecord::Base
  end

  def up
    add_column :items, :temperature_when_created, :decimal
    add_column :items, :temperature_when_completed, :decimal
    
    Item.find_each do |item|
      item.temperature_when_created = ForecastIO.forecast(41.2587361,-95.9304049, time: item.created_at.to_i).currently.temperature
      
      if item.completed_at.present?
        item.temperature_when_completed = ForecastIO.forecast(41.2587361,-95.9304049, time: item.completed_at.to_i).currently.temperature
      end
      
      item.save!
    end
  end
  
  def down
    remove_column :items, :temperature_when_created
    remove_column :items, :temperature_when_completed
  end
end
