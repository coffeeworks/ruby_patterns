# Script for migrating data between different models

class UserMigrator < ModelMigrator
  protected

  def origin_class
    User
  end

  def target_class
    Profile
  end

  def converted_attributes(user)
    {
      :id => user.id
      :name => user.full_name,
      :email => user.emails.first.address,
      :website => user.website.url
    }
  end
end

# Run: UserMigrator.new.migrate

class ModelMigrator
  def initialize(dry_run = false)
    @migrated = 0
    @errors = 0
    @error_rows = []
    @dry_run = dry_run
  end

  def migrate
    collection.each do |obj|
      if migrate_obj(obj)
        @migrated += 1
      else
        @errors += 1
        @error_rows << obj.id
      end
    end

    puts "Migrated #{@migrated} records"
    puts "#{@errors} errors"
    puts "Errors on rows: #{@error_rows.inspect}" unless @error_rows.empty?
  end

  def migrate_obj(old_model)
    new_model = target_class.new
    after_initialize(new_model)
    new_model.attributes = converted_attributes(old_model)
    before_save(new_model, old_model)

    if @dry_run
      if new_model.valid?
        return true
	    else
        puts "Errors on #{old_model.id}): #{new_model.errors.full_messages}"
        return false
      end
    else
      if new_model.save
        after_save(new_model, old_model)
        puts "Saved #{new_model.class}: #{new_model.id}"
        return true
      else
        puts "Errors on #{old_model.id}): #{new_model.errors.full_messages}"
        return false
      end
    end

  end

  protected
  # Overridable methods

  def origin_class
    raise "Override this"
  end

  def target_class
    raise "Override this"
  end

  def converted_attributes(old_model)
    raise "Override this"
  end

  def collection
    origin_class.find(:all)
  end

  # Hooks
  def after_initialize(new_model)
  end

  def before_save(new_model, old_model)
  end

  def after_save(new_model, old_model)
  end
end

