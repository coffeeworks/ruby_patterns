User.all.class
# => DataMapper::Collection

User.all
# SQL (1839.206ms)  SELECT * FROM users
# => [.....]

collection = User.all(:first_name.like => 'N%') + User.all(:last_name.like => 'G%')
collection = collection.all(:country => 'Argentina')
collection
# SQL (1839.206ms)  SELECT * FROM users WHERE (first_name LIKE 'N%' or last_name LIKE 'G%) and country = 'Argentina'
# => [.....]

# DataMapper::Logger.new($stdout, :debug)

