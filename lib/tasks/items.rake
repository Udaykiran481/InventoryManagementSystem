namespace :es do
    namespace :items do
      desc 'Create Elasticsearch index for items'
      task create_index: :environment do
        Item.__elasticsearch__.create_index!(force: true)
        Item.import
        puts 'Elasticsearch index for items created successfully'
      end
    end
end
  