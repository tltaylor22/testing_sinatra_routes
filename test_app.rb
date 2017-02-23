require 'minitest/autorun'
require 'rack/test'
require_relative '../app.rb'

class TestApp < Minitest::Test
	include Rack::Test::Methods

	def app
		PersonalDetailsApp
	end

	def test_ask_name_on_entry_page
		get '/'
		assert(last_response.ok?)
		assert(last_response.body.include?('Hello, what is your name'))
		assert(last_response.body.include?('<form method="post" action="/name">'))
		assert(last_response.body.include?('<input type="text" name="name_input">'))
		assert(last_response.body.include?("<input type='submit' value= 'Submit'>"))
	end

	def test_post_to_name
		post '/name', name_input: 'Jon'
		follow_redirect!
		assert(last_response.body.include?('Jon'))
		assert(last_response.ok?)
	end

	def test_get_age
		get '/age?name=Tim'
		assert(last_response.body.include?('Hello, Tim! How old are you'))
		assert(last_response.ok?)
	end

	def test_pass_to_age
		post '/age', age_input: '56', name_input: 'Tim' follow_redirect!
		assert(last_response.body.include?('56'))
		assert(last_response.ok?)
	end

	# def test_get_fav_nums
	# 	get '/favnums?age=56, name=Tim'
	# 	assert(last_response.body.include?('Tim, you are 56 years old. What are your three favorite numbers?'))
	# 	assert(last_response.ok?)
	# end
	
	# def test_pass_to_fav_nums
	# 	post '/favnums', num1_input: '1', num2_input: '2', num3_input '3', age_input: '56', name_input: 'Tim' follow_redirect!
	# 	assert(last_response.body.include?('1', '2', '3'))
	# 	assert(last_response.ok?)
	# end

end
