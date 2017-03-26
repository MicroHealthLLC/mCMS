class GroupsController < ProtectForgeryApplication
  add_breadcrumb I18n.t('home'), :root_path
  add_breadcrumb I18n.t('groups'), :groups_path
  before_action  :authenticate_user!

  before_filter :set_group, only: [:show, :edit, :update, :destroy, :remove_member, :add_member]
  before_filter :require_admin, except: [:show]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group
    else
      redirect_to "/"
    end
  end

  def edit
  end

  def update
    @group.update_attributes(group_params)
    redirect_to @group
  end

  def add_member
    leader = Membership.new(leader_params)
    leader.group_id = params[:id]
    leader.save

    redirect_to edit_group_path(params[:id])
  end

  def remove_member
    @member = if "#{params[:membership][:level]}" == "#{Membership::LEVELS[:leader]}"
                @group.leader_members.detect{|m| m.user_id.to_s ==  params[:membership][:user_id]}
              else
                @group.regular_members.detect{|m| m.user_id.to_s ==  params[:membership][:user_id]}
              end

    @member.delete if @member
    redirect_to edit_group_path(params[:id])
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
    add_breadcrumb @group, @group
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def leader_params
    params.require(:membership).permit(:user_id, :level)
  end

end
