require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get track" do
    get :track
    assert_response :success
  end

end
