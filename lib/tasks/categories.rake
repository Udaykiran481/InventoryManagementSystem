namespace :es do
    namespace :categories do
      desc 'Create Elasticsearch index for categories'
      task create_index: :environment do
        Category.__elasticsearch__.create_index!(force: true)
        Category.import
        puts 'Elasticsearch index for categories created successfully'
      end
    end
end
  