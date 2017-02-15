class CategoriesList < ActiveRecord::Migration[5.0]
  def up
    Category.delete_all
    ['Asia', 'Africa', 'Antarctica', 'Australia', 'Europe', 'North America', 'South America'].each do |cat|
      Category.create(name: cat)
    end
  end

  def down
    puts 'Nope'
  end
end
