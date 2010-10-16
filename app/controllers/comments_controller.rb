class CommentsController < InheritedResources::Base
  actions
  nested_belongs_to :project, :ticket
end
