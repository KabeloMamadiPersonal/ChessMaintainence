require './app/controllers/members_controller'
require 'rails_helper'
# require Rails.root.join('db/migrate/20211013180101_create_member.rb')

RSpec.describe MembersController, type: :controller do
  describe 'create member' do
    it 'create using the parameters' do
      test_name = 'Peter'
      surname = 'Drury'
      email = 'peterdrury@gmail.com'
      birthday = '01/01/1991'
      post :create, params: { member: { name: test_name, surname: surname, birthday: birthday,
                                        email: email } }
      expect(Member.all.count).to eq 1
      # expect(Member.first.name).to eq test_name
      expect(Member.first.surname).to eq surname
      expect(Member.first.email).to eq email
      expect(Member.first.rank).to eq rank
    end
  end
end