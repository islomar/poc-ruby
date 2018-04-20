describe 'Hello world' do
    it 'returns hello world' do
      get '/'

      expect(last_response).to be_ok
    end
end