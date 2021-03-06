stop_words = %w{the a by on for of are with just but and to the my I has some in}
lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join

#Count the characters
total_char = text.length
total_char_nosp = text.gsub(/\s+/,'').length

#Count the spaces, words, sentences and paragraphs
total_sp = total_char - total_char_nosp
word_count = text.split.length
paragraph_count = text.split(/\n\n/).length
sentence_count = text.split(/\.|\?|!/).length

=begin
Make a list of words in the text that aren't stop words,
count them, and work out percentage of non-stop words
agains all words
=end
all_words = text.scan(/\w+/)
good_words = all_words.select{ |word| !stop_words.include?(word)}
good_percentage = ((good_words.length.to_f / all_words.length.to_f) * 100).to_i

#Summarize the text by cherry picking some choice senteces
sentences = text.gsub(/\s+/,' ').strip.split(/\.|\?|\!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length}
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/}

#Give the  analysis back to the user
puts "Lines:- #{line_count}"
puts "Character :- #{total_char}"
puts "Charachter Excluding spaces :- #{total_char_nosp} "
puts "Spaces :- #{total_sp}"
puts "Words :- #{word_count}" 
puts "Paragraphs :- #{paragraph_count}"
puts "Sentences :- #{sentence_count}"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "#{good_percentage}% of words are non-fluff words"
puts "Summary:\n\n" + ideal_sentences.join(" -- ")
puts " \n --------- End of Analysis -----------"


