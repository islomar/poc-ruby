def upper_case_words(sentence)
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
end