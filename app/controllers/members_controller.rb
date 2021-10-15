class MembersController < ApplicationController

  before_action :authenticate_user!

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
      match = Match.create!(first_member_id: match_params[:first_member_id],
                            second_member_id: match_params[:second_member_id],
                            winning_member_id: match_params[:winning_member_id])
      match.log_result
      redirect_to members_view_all_path
    end
  end

  def show
    @members = Member.where(active: true).order(rank: :asc)
  end

  private

  def member_params
    params.require(:member).permit(:id, :name, :surname, :email, :birthday)
  end

  def match_params
    params.require(:match).permit(:first_member_id, :second_member_id, :winning_member_id)
  end
end