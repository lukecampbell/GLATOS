class SubmissionObserver < ActiveRecord::Observer

  def after_create(submission)
    SubmissionMailer.new_submission(submission).deliver
  end
end
