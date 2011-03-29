require 'grit'
require 'gollum'
require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :redmine_model_dependencies do
  require_dependency 'project'
  require_dependency 'user'
  require_dependency 'projects_helper'
  require_dependency 'gollum_projects_helper_patch'
  require_dependency 'projects_controller'
  require_dependency 'gollum_projects_controller_patch'
end

Dispatcher.to_prepare :redmine_gollum do
  ProjectsHelper.send(:include, GollumProjectsHelperPatch) unless ProjectsHelper.included_modules.include?(GollumProjectsHelperPatch)
  ProjectsController.send(:include, GollumProjectsControllerPatch) unless ProjectsController.included_modules.include?(GollumProjectsControllerPatch)
end

Redmine::Plugin.register :redmine_gollum_wiki do
  name 'Redmine Gollum plugin'
  author 'Kang-min Liu <gugod@gugod.org>'
  description 'Integration of gollum (github wiki) with Redmine'
  version '0.0.1'
  url 'https://github.com/gugod/redmine-gollumn/'
  # author_url 'http://gugod.org'

  requires_redmine :version_or_higher => '1.1.0'

  project_module :gollum_wiki do
    permission :view_gollum_wiki,   :gollum => [:index, :show]
    permission :add_gollum_wiki,    :gollum => [:new, :create]
    permission :edit_gollum_wiki,   :gollum => [:edit, :update]
    permission :delete_gollum_wiki, :gollum => [:destroy]

    permission :manage_gollum_wiki, :gollum_wikis => [:index,:show, :update]
  end

  menu :project_menu, :gollum, { :controller => :gollum, :action => :index }, :caption => 'Wiki', :before => :wiki, :param => :project_id
end

Redmine::Activity.map do |activity|
  activity.register :gollum_wiki
end
