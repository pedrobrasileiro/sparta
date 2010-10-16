class CommentsController < InheritedResources::Base
  nested_belongs_to :project, :ticket
end
