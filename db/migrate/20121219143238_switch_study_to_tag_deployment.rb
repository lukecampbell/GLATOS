class SwitchStudyToTagDeployment < ActiveRecord::Migration
  def up
    add_column :tag_deployments, :study_id, :integer
    Tag.includes(:tag_deployments).each do |t|
        t.tag_deployments.each do |d|
            d.study_id = t.study_id
            d.save!
        end
    end
    remove_column :tags, :study_id
  end

  def down
    add_column :tags, :study_id, :integer
    # Sets the Tag's study to the active deployment
    # Information about which Study a TagDeployment 
    # is tied to is LOST here.
    Tag.includes(:tag_deployments).each do |t|
        t.study_id = t.active_deployment.study_id
        t.save!
    end
    remove_column :tag_deployments, :study_id
  end
end
