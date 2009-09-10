require File.dirname(__FILE__) + '/../test_helper'
require 'deliveries_controller'

# Re-raise errors caught by the controller.
class DeliveriesController; def rescue_action(e) raise e end; end

class DeliveriesControllerTest < Test::Unit::TestCase
  fixtures :deliveries

  def setup
    @controller = DeliveriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:deliveries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_delivery
    old_count = Delivery.count
    post :create, :delivery => { }
    assert_equal old_count + 1, Delivery.count

    assert_redirected_to delivery_path(assigns(:delivery))
  end

  def test_should_show_delivery
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_delivery
    put :update, :id => 1, :delivery => { }
    assert_redirected_to delivery_path(assigns(:delivery))
  end

  def test_should_destroy_delivery
    old_count = Delivery.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Delivery.count

    assert_redirected_to deliveries_path
  end
end
