class Match < ActiveRecord::Base

  # Update the rank of the members who have played based on result
  def log_result
    first_member = Member.find(first_member_id)
    second_member = Member.find(second_member_id)
    winning_member = winning_member_id
    first_member.games_played += 1
    second_member.games_played += 1
    case winning_member
    when 1
      calculate_rank(first_member, second_member)
    when 2
      calculate_rank(second_member, first_member)
    when 3
      if (first_member.rank - second_member.rank).abs > 1
        if first_member.rank > second_member.rank
          first_member.rank -= 1
          Member.where(rank: first_member.rank).update(rank: first_member.rank + 1)
        else
          second_member.rank -= 1
          Member.where(rank: second_member.rank).update(rank: second_member.rank + 1)
        end
      end
      first_member.save!
      second_member.save!
    end
  end

  # Update the leader board to factor in the latest result and new ranks
  def calculate_rank(winner, loser)
    if winner.rank > loser.rank
      lower_rank = winner.rank
      higher_rank = loser.rank
      winner.rank = lower_rank - ((lower_rank - higher_rank) / 2)
      Member.where('rank >= ?', winner.rank).update_all('rank = rank + 1')
      loser.rank = higher_rank + 1
      Member.where(rank: loser.rank).update(rank: loser.rank - 1)
    end
    winner.save!
    loser.save!
  end
end
