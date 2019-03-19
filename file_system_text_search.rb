# frozen_string_literal: true
require 'json'

file = File.read('input.json')
endpoint_data = JSON.parse(file)

view_files = (Dir['./search_directory/**/*.vm'] +
Dir['./search_directory/**/*.js'] -
Dir['./search_directory/**/vendor/**/*.js'] -
Dir['./search_directory/**/foundation/**/*.js'])

def get_controller_name str
  str.split('.').last
end

endpoint_data.each do |endpoint|
  key = endpoint.keys.first
  controller = get_controller_name key
  request_path = endpoint[key]['patternsCondition']['patterns'][0]
  method = endpoint[key]['methodsCondition']['methods'][0] || 'GET'

  search_text = request_path.gsub(/{[a-zA-Z]+}/, '*')[1..-1].gsub('/', '\/')

  matched_files = []
  view_files.each do |f|
    File.open(f, 'r').each do |line|
      if (line.match(/\b#{search_text}\b/i))
        matched_files << f.gsub('./search_directory/', '')
        break
      end
    end
  end

  puts "#{controller},#{request_path},#{method},#{matched_files.join(';')}"
  
end

