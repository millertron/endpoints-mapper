(Dir["./search_directory/**/*.vm"]+Dir["./search_directory/**/*.js"]-Dir["./search_directory/**/vendor/**/*.js"]-Dir["./search_directory/**/foundation/**/*.js"]).each do |file|
  puts file
end
