# ActiveRecord 3 allows changing the serialization method using the strategy pattern
# See http://edgerails.info/articles/what-s-new-in-edge-rails/2011/03/09/custom-activerecord-attribute-serialization/index.html

class JsonSerializer
  def load(json)
    JSON.parse(json)
  end

  def dump(hash)
    hash.to_json
  end
end

class User < ActiveRecord::Base
  serialize :extra_info, JsonSerializer.new
end

User.create(:name => 'Mr. T', :extra_info => {:twitter => '@mr_tweets'})
# INSERT INTO "users" ("created_at", "name", "extra_info") VALUES ("2011-03-05 17:12:01.459862", "Mr. T", "{twitter: '@mr_tweets'}")

