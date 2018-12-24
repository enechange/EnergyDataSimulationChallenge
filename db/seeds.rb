# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

class Seed
  attr_reader :logger
  attr_reader :std_logger

  def initialize
    @logger = Rails.logger
    @std_logger = Logger.new(STDOUT)
  end

  def log_info(msg)
    @logger.info(msg)
    @std_logger.info(msg)
  end

  def execute
    Dir.glob(Rails.root.join('db', 'seeds', '*')).each do |f, i|
      model_klass = File.basename(f, '.csv').classify.constantize
      log_info('------------------------------')
      log_info("truncate: #{model_klass.table_name}")
      rs = ApplicationRecord.connection.execute "TRUNCATE TABLE #{model_klass.table_name};"

      mr = []
      CSV.foreach(f, headers: true) do |cr|
        mr << model_klass.new(cr.to_h)
      end
      rs = model_klass.import(mr, on_duplicate_key_update: model_klass.attribute_names.reject { |k| ["id", "created_at", "updated_at"].include?(k) })

      log_info("updated: #{model_klass.table_name} #{rs.inspect}")
    end
  end
end

Seed.new.execute