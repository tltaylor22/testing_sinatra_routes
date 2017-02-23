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
		assert(last_response.body.include?('<form action="/name" method="post">'))
		assert(last_response.body.include?('<input type="text" name="name_input">'))
		assert(last_response.body.include?("<input type='submit' value='submit'>"))
	end

	def test_post_to_name
		post '/name', name_input: 'Jon'
		follow_redirect!
		assert(last_response.body.include?('Jon'))
		assert(last_response.ok?)
	end

	def test_get_age
		get '/age?name=Tim'
		assert(last_response.body.include?('Nice to meet you Tim. How old are you'))
		assert(last_response.ok?)
	end

	def test_pass_to_age
		post '/age', age_input: '56', name_input: 'Tim'
		follow_redirect!
		assert(last_response.body.include?('56'))
		assert(last_response.ok?)
	end

	def test_get_fav_nums
		get '/favnums?age=56&name=Tim'
		assert(last_response.body.include?('56'))
		assert(last_response.body.include?('Tim'))
		assert(last_response.ok?)
	end
	
	def test_pass_to_fav_nums
		post '/favnums', fav_num1_input: '1', fav_num2_input: '2', fav_num3_input: '3', age_input: '56', name_input: 'Tim', sum: '6', results: 'less than'
		assert(last_response.body.include?('1'))
		assert(last_response.body.include?('2'))
		assert(last_response.body.include?('3'))
		assert(last_response.body.include?('56'))
		assert(last_response.body.include?('Tim'))
		assert(last_response.body.include?('6'))
		assert(last_response.body.include?('less than'))
		assert(last_response.ok?)
	end

end
