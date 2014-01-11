require 'spec_helper'

describe NewRelic::Agent::Instrumentation::Grape do

  subject { NewRelic::Agent::Instrumentation::Grape }

  let(:app) { Class.new(Grape::API) }

  before do
    app.get :hello do
      "Hello World"
    end
  end

  it "perform_action_with_newrelic_trace" do
    subject.any_instance.should_receive(
      :perform_action_with_newrelic_trace
    ).and_yield

    get '/hello'
  end

  it "logs the transaction with a formatted path" do
    subject.any_instance.should_receive(
      :perform_action_with_newrelic_trace
    ).with do |t|
      expect(t[:path]).to eq('GET hello(.:format)')
    end.and_yield

    get '/hello'
  end

end

