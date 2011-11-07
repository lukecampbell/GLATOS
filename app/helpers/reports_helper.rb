module ReportsHelper

  def tags_and_active_deployments
    select_tag "stuff", options_for_select(Tag.all.map{|s| [s.code, s.active_deployment.id]}), :class => 'tagger', :include_blank => true
  end

end
