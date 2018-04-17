def upper_case_words(sentence)
	if not sentence.is_a? String
		raise TypeError.new 'Hey, I wanted a string'
	end
	return sentence.split.map(&:capitalize).join(" ")
	# return sentence.split.each{|word| word.capitalize!}.join(' ')
end

describe '#upper_case_words' do
	it 'should upper case a single world' do
		actual = upper_case_words('hello')

		expected = 'Hello'
		expect(actual).to eq expected
    end

	it 'should upper case an entire sentence' do
		actual = upper_case_words('hello qualified codecast audience')

		expected = 'Hello Qualified Codecast Audience'
		expect(actual).to eq expected
	end

	it 'should raise TypeError for non strings' do
		expect { upper_case_words(123) }.to raise_error(TypeError)
	end
end