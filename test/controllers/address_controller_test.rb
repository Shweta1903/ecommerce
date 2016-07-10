require 'test_helper'

class AddressControllerTest < ActionController::TestCase
  test "should get first_name:string" do
    get :first_name:string
    assert_response :success
  end

  test "should get last_name:string" do
    get :last_name:string
    assert_response :success
  end

  test "should get address1:string" do
    get :address1:string
    assert_response :success
  end

  test "should get address2:string" do
    get :address2:string
    assert_response :success
  end

  test "should get city:string" do
    get :city:string
    assert_response :success
  end

  test "should get state_name:string" do
    get :state_name:string
    assert_response :success
  end

  test "should get zip_code:string" do
    get :zip_code:string
    assert_response :success
  end

  test "should get user:references" do
    get :user:references
    assert_response :success
  end

end
