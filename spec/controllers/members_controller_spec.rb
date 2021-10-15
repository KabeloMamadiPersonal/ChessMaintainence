require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  describe 'create member' do
    it 'create using the parameters' do
      member_count = Member.all.count
      test_name = 'Peter'
      surname = 'Drury'
      email = 'peterdrury@gmail.com'
      birthday = '01/01/1991'
      post :create, params: { member: { name: test_name, surname: surname, birthday: birthday,
                                        email: email } }
      expect(Member.all.count).to eq (member_count + 1)
      expect(Member.last.surname).to eq surname
      expect(Member.last.email).to eq email
      expect(Member.last.rank).to eq (member_count + 1)
      
    end
  end
end