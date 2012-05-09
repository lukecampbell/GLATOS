class ReportMailer < ActionMailer::Base

  def report_invoice(report)
    @report = report
    recips = @report.email
    mail(:to => recips, :subject => "[GLATOS] Report Confirmation")
  end

  def unmatched_report_notification(report)
    @report = report
    recips = User.where("role = 'admin'").map(&:email)
    mail(:to => recips, :subject => "[GLATOS] Unmatched Tag Report Submitted")
  end

  def matched_report_notification(report)
    @report = report
    recips = @report.tag_deployment.tag.study.user.email
    ccs = User.where("role = 'admin'").map(&:email)
    mail(:to => recips, :cc => ccs, :subject => "[GLATOS] Tag Report Submitted")
  end

end
