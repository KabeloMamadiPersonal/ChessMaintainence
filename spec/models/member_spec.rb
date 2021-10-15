require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'create match' do
    it 'will store match details' do
      first_member = Member.create!(name: 'Peter', surname: 'Griffin')
      second_member = Member.create!(name: 'Luke', surname: 'Griffin')
      Match.create!(first_member_id: first_member.id, second_member_id: second_member.id, winning_member_id: 1)

      expect(Member.all.count).to eq 2
      expect(Match.all.count).to eq 1
      expect(Match.first.first_member_id).to eq first_member.id
      expect(Match.first.second_member_id).to eq second_member.id
    end
  end
end