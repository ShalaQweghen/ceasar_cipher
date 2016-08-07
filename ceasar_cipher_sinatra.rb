require "sinatra"
require "sinatra/reloader" if development?

get "/" do
	erb :form
end

post "/" do
	words = params["word"]
	shift = params["shift"].to_i
	message = cipher(words, shift)
	erb :result, :locals => { :message => message }
end

def cipher (string, num)
	a = 0
	word = string.chars
	word.each do
		if [32, 33, 63, 46, 44].include?(word[a].ord)
			word[a]
		else
			word[a] = word[a].ord
			if word[a].between?(97, 122)
				(word[a] + num) > 122 ? word[a] = ((word[a] + num) - 122 + 96).chr : word[a] = (word[a] + num).chr
			elsif word[a].between?(65, 90)
				(word[a] + num) > 90 ? word[a] = ((word[a] + num) - 90 + 65).chr : word[a] = (word[a] + num).chr
			elsif word[a].between?(48, 57)
				(word[a] + num) > 57 ? word[a] = ((word[a] + num) - 57 + 48).chr : word[a] = (word[a] + num).chr
			end
		end
		a += 1
	end
	word.join
end