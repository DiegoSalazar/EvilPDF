require 'test_helper'

class PdfRecordsControllerTest < ActionController::TestCase
  setup do
    @pdf_record = pdf_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pdf_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pdf_record" do
    assert_difference('PdfRecord.count') do
      post :create, pdf_record: { content: @pdf_record.content, name: @pdf_record.name, pdf_content_type: @pdf_record.pdf_content_type, pdf_file_name: @pdf_record.pdf_file_name, pdf_file_size: @pdf_record.pdf_file_size }
    end

    assert_redirected_to pdf_record_path(assigns(:pdf_record))
  end

  test "should show pdf_record" do
    get :show, id: @pdf_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pdf_record
    assert_response :success
  end

  test "should update pdf_record" do
    put :update, id: @pdf_record, pdf_record: { content: @pdf_record.content, name: @pdf_record.name, pdf_content_type: @pdf_record.pdf_content_type, pdf_file_name: @pdf_record.pdf_file_name, pdf_file_size: @pdf_record.pdf_file_size }
    assert_redirected_to pdf_record_path(assigns(:pdf_record))
  end

  test "should destroy pdf_record" do
    assert_difference('PdfRecord.count', -1) do
      delete :destroy, id: @pdf_record
    end

    assert_redirected_to pdf_records_path
  end
end
