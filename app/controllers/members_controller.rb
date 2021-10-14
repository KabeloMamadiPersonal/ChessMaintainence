class MembersController < ApplicationController

  def new
    @member = Member.new
  end

  def create
    rank = Member.where(active: true).count + 1
    member = Member.new(name: member_params[:name], surname: member_params[:surname], email: member_params[:email],
                        birthday: member_params[:birthday], rank: rank, games_played: 0)
    member.save!
    redirect_to members_view_all_path
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    member = Member.find(member_params[:id])
    member.update(name: member_params[:name], surname: member_params[:surname], email: member_params[:email],
                  birthday: member_params[:birthday])
    redirect_to members_view_all_path
  end

  def destroy
    member = Member.find(params[:id])
    rank = member.rank
    Member.where('rank > ?', rank).update_all('rank = rank - 1')
    member.update!(active: false)
    redirect_to members_view_all_path
  end

  def log_match
    if params[:match].present?
      first_member = Member.find(match_params[:first_member_id])
      second_member = Member.find(match_params[:second_member_id])
      winning_member = match_params[:winning_member_id]
      Match.create!(first_member_id: first_member.id, second_member_id: second_member.id,
                    winning_member_id: winning_member)
      first_member.games_played += 1
      second_member.games_played += 1
      case winning_member
      when '1'
        calculate_rank(first_member, second_member)
      when '2'
        calculate_rank(second_member, first_member)
      when '3'
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
      redirect_to members_view_all_path
    end
  end

  def show
    @members = Member.where(active: true).order(rank: :asc)
  end

  def member_params
    params.require(:member).permit(:id, :name, :surname, :email, :birthday)
  end

  def match_params
    params.require(:match).permit(:first_member_id, :second_member_id, :winning_member_id)
  end

  private

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