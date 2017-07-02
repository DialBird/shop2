module ControllerMacros
  def login_user
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:registerd_user)
    end
  end
end
