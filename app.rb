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
		# redirect '/favnums?age=' + age + '&name' + name
	end

	get '/favnums' do
		name = params[:name]
		age = params[:age]
		"#{name} and #{age}"  # What the hell does this do???
	end

	post '/favnums' do
		name = params[:name_input]
		age = params[:age_input],to_i
		backend_num1 = params[:fav_num1_input].to_i
		backend_num2 = params[:fav_num2_input].to_i
		backend_num3 = params[:fav_num3_input].to_i
		sum = (backend_num1 + backend_num2 + backend_num3)

		results = 'less than'
			if (sum > backend_age)
				results = 'greater than'
			elsif (sum == backend_age)
				results = 'equal to'
			else
				results
			end
		redirect '/results?favnums=' + favnums + '&age' + age + '&name' + name
	end

	get '/results' do
		name = params[:name]
		age = params[:age]
		favnums = params[:favnums]
		"#{name} and #{age} and #{favnums}"	
	end

end

