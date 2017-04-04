require 'csv'
class AddLanguages < ActiveRecord::Migration[5.0]
  def up
    create_table :languages do |t|
      t.string :name
      t.string :code
    end

    file = File.join(Rails.root, 'db', 'files', 'languages.csv')
    csv_text = File.read(file)
    if csv_text.present?
      csv = CSV.parse(csv_text, :headers => false)
      csv.each do |row|
        Language.where(name: row[1], code: row[0]).first_or_create
      end
      puts 'Languages are created are updated.'
    end
  end

  def down
    drop_table :languages
  end
end
