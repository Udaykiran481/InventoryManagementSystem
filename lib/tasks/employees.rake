namespace :es do
    namespace :employees do
      desc 'Create Elasticsearch index for employees'
      task create_index: :environment do
        Employee.__elasticsearch__.create_index!(force: true)
        Employee.import
        puts 'Elasticsearch index for employees created successfully'
      end
    end
  end
  