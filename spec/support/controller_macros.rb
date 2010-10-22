module ControllerMacros
  def sign_in_user
    before do
      sign_in Factory(:user)
    end
  end
end
