require 'sinatra'

class PersonalDetailsApp < Sinatra::Base

	get '/' do
		erb :name
	end

	post '/name' do
		name = params[:name_input]
		redirect '/age?name=' + name
	end

	get '/age' do
		name = params[:name]
		erb :age, locals: {name: name}
	end

	post '/age' do
		name = params[:name_input]
		age = params[:age_input]
		redirect '/favnums?age=' + age + '&name' + name
	end

	get '/favnums' do
		name = params[:name]
		age = params[:age]
		"#{name} and #{age}"
	end

	post '/favnums' do
		name = params[:name_input]
		age = params[:age_input]
		redirect '/results?favnums=' + favnums + '&age' + age + '&name' + name
	end

	get '/results' do
		name = params[:name]
		age = params[:age]
		favnums = params[:favnums]
		"#{name} and #{age} and #{favnums}"	
	end

end

