module ControllerMacros
  def sign_in_user
    before do
      @user = Factory(:user)
      sign_in @user
    end
  end
end
