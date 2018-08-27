class EasyredmineHelpdeskSelfSignupMailer < Mailer
  
  
  def signup_notification(user, to = [])
    
    @user = user
    @projects = if user.matcher_project_matchings.present?
      user.matcher_project_matchings.map {|matching| matching.easy_helpdesk_project.project }
    else
      []
    end
    
    
    mail :to => to, :subject => "New User self-signup: #{user.login}"
    
  end
  
end