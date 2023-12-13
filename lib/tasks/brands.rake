namespace :es do
    namespace :brands do
      desc 'Create Elasticsearch index for brands'
      task create_index: :environment do
        Brand.__elasticsearch__.create_index!(force: true)
        Brand.import
        puts 'Elasticsearch index for brands created successfully'
      end
    end
end
  