require 'test_helper'

class SendMailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @send_mail = send_mails(:one)
  end

  test "should get index" do
    get send_mails_url
    assert_response :success
  end

  test "should get new" do
    get new_send_mail_url
    assert_response :success
  end

  test "should create send_mail" do
    assert_difference('SendMail.count') do
      post send_mails_url, params: { send_mail: { attachment: @send_mail.attachment, mail_from: @send_mail.mail_from, mail_to: @send_mail.mail_to, type_mail: @send_mail.type_mail } }
    end

    assert_redirected_to send_mail_url(SendMail.last)
  end

  test "should show send_mail" do
    get send_mail_url(@send_mail)
    assert_response :success
  end

  test "should get edit" do
    get edit_send_mail_url(@send_mail)
    assert_response :success
  end

  test "should update send_mail" do
    patch send_mail_url(@send_mail), params: { send_mail: { attachment: @send_mail.attachment, mail_from: @send_mail.mail_from, mail_to: @send_mail.mail_to, type_mail: @send_mail.type_mail } }
    assert_redirected_to send_mail_url(@send_mail)
  end

  test "should destroy send_mail" do
    assert_difference('SendMail.count', -1) do
      delete send_mail_url(@send_mail)
    end

    assert_redirected_to send_mails_url
  end
end
