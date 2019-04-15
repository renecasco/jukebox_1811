class Admin::AwardsController < Admin::BaseController

  def create
    @award = Award.create(award_params)
    redirect_to awards_path
  end

  private

  def award_params
    params.require(:award).permit(:name)
  end

end
