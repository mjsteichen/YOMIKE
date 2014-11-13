require 'twilio-ruby'
helpers do
  def send_text(name)
    account_sid = 'AC5cf5b940a53188afbb3193b9bbdde63f'
    auth_token = '1e5c28c761021439d5f977f6e55b333a'

    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.account.messages.create({
      :from => '+18452057101',
      :to => '+19188041126',
      :body => "Yo Mike! Make #{name} some coffee",
      })
  end
end
