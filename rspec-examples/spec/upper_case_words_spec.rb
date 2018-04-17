require 'upper_case_words'

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