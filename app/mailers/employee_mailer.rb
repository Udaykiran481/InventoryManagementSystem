class EmployeeMailer< ApplicationMailer
    def issue_resolved_email(user, item, issue,resolved_at )
      @user = user
      @item=item
      @issue = issue
      @resolved_at=resolved_at
      mail(to: @user.email, subject: 'Issue Resolved Notification')
    end
end
  