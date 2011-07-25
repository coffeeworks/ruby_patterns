# See https://github.com/josevalim/inherited_resources

class ProjectsController < InheritedResources::Base
  protected

  def collection
    @projects = Project.filter_for(current_user).paginate(:page => params[:page])
  end
end

