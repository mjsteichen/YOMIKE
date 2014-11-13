enable 'sessions'

get '/' do
  erb :index
end

get '/users/:user_id' do
  @user = User.find(session[:user_id])
  erb :user_home
end

post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])
  # binding.pry
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @error = "Invalid email/password"
    erb :index
  end
end

get '/signup' do
  erb :signup
end

post '/users' do
  @user = User.new(full_name: params[:full_name], email: params[:email], password: params[:password], phone_number: params[:phone_number])
  @errors = @user.errors
  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :signup
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/text_mike' do
  @user = User.find(session[:user_id])
  send_text(@user.full_name)
  redirect "/users/#{@user.id}"
end
