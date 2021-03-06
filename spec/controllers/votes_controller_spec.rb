require 'spec_helper'
describe VotesController do
  let(:question){FactoryGirl.create(:question)}
  let(:user){FactoryGirl.create(:user)}
  let(:answer){FactoryGirl.create(:answer)}
  let(:question_up_vote){post :create, :vote_data => {:value => 1, :votable_id => question.id,
        :votable_type=> "Question", :user_id=> user.id}, :format=> :json}
  let(:answer_vote){post :create, :vote_data=> {:value => 1, :votable_id => answer.id,
        :votable_type=> "Answer", :user_id=> user.id}, :format=> :json}

  context "create" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "creates a vote for a question" do
      expect{ question_up_vote }.to change{Vote.count}.by(1)
    end

    it "changes a question's vote_count for an up vote" do
      expect{question_up_vote}.to change{question.reload.vote_count}.by(1)
    end

    it "changes a question's vote_coutn for a down vote" do
      expect{
        post :create, :vote_data=> {:value => -1, :votable_id => question.id,
        :votable_type=> "Question", :user_id=> user.id}
      }.to change{question.reload.vote_count}.by(-1)
    end

    it "creates a vote for an answer" do
      expect{answer_vote}.to change{Vote.count}.by(1)
    end

    it "changes an answer's vote_count" do
      expect{answer_vote}.to change{answer.reload.vote_count}.by(1)
    end

    it "responds to json by rendering json for a question" do
      question_up_vote
      expect(response.body).to eq(question.reload.to_json)
    end

    it "responds to json by rendering json for an answer" do
      answer_vote
      expect(response.body).to eq(answer.reload.to_json)
    end


  end
end