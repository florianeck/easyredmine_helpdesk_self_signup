class EasyredmineHelpdeskSelfSignup::MailDomainMatcher
  
  attr_reader :user_email
  attr_accessor :mail_domains, :project_matchings
  
  def initialize(user_email)
    @user_email = user_email
    get_mail_domains
    get_project_matchings
  end
  
  def get_mail_domains
    @mail_domains = [
      @user_email.split("@").last
    ]
    
    splitted_mail_parts = @mail_domains.first.split(".")
    i = 1
    i_max = splitted_mail_parts.size-1
    
    while i < i_max
      @mail_domains << splitted_mail_parts[i..-1].join(".")
      i += 1
    end  
    
    @mail_domains
  end
  
  def get_project_matchings
    @project_matchings = mail_domains.map {|d| EasyHelpdeskProjectMatching.find_by(email_field: 'from', domain_name: d) }.compact
  end
  
  
  
end