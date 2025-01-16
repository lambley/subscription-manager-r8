RSpec.shared_examples 'GET request examples' do
  it "returns http success" do
    send(:get, subscription_path(subscription))
    expect(response).to have_http_status(:success)
  end

  it "should have the correct url" do
    send(:get, subscription_path(subscription))
    expect(request.original_fullpath).to eq(subscription_path(subscription))
  end

  it "should have the correct instance variable" do
    send(:get, subscription_path(subscription))
    expect(assigns(:subscription)).to eq(subscription)
  end
end

RSpec.shared_examples 'PATCH request examples' do |message|
  it "should update the record" do
    expect(subscription.name).to eq(updated_params[:name])
  end

  it "should redirect to the correct path" do
    expect(response).to redirect_to(subscription_path(subscription))
  end

  it "should have the correct flash message" do
    expect(flash[:notice]).to eq(message)
  end
end

RSpec.shared_examples 'PATCH invalid request examples' do
  it "should not update the record" do
    expect(subscription.name).not_to eq(updated_params[:name])
  end

  it "should render the edit template" do
    expect(response).to render_template(:edit)
  end
end

RSpec.shared_examples 'DELETE request examples' do |message|
  it "should delete the record" do
    expect { send(:delete, subscription_path(subscription)) }.to change(Subscription, :count).by(-1)
  end

  it "should redirect to the correct path" do
    send(:delete, subscription_path(subscription))
    expect(response).to redirect_to(subscriptions_path)
  end

  it "should have the correct flash message" do
    send(:delete, subscription_path(subscription))
    expect(flash[:notice]).to eq(message)
  end
end
