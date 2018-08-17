class AddIsinfectedToSurvivors < ActiveRecord::Migration
  def change
    add_column :survivors, :is_infected, :boolean, default: false
  end
end
