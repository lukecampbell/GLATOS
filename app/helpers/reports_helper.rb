module ReportsHelper

  def tags_and_active_deployments
    select_tag "stuff", options_for_select(Tag.includes(:tag_deployments).map{|s| [s.code, s.active_deployment.id]}), :class => 'tagger', :include_blank => true
  end

end
