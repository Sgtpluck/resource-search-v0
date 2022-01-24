require "rails_helper"

RSpec.describe Query::Type, type: :model do
  def search_term(merge_terms = {})
    {
      "Template" => "0",
      "Example" => "0",
      "Training" => "1",
      "Guide" => "0",
      "Case Study" => "0",
      "Report" => "0"
    }.merge(merge_terms)
  end

  before { allow(Analytic).to receive(:create) }
  let(:query) { Query::Type.new(search_term) }

  describe "#initalize" do
    it "crates the value array" do
      expect(query.values).to eq ["Training"]
    end

    it "creates a new Analytic object" do
      expect(Analytic).to receive(:create)

      query.values
    end
  end

  describe "#query_string" do
    describe "only one type checked" do
      it "returns an OR search query format for recomended projects" do
        query_str = "OR(SEARCH('Training', {Type of Resource}))"

        expect(query.query_string).to eq query_str
      end
    end

    describe "multiple types checked" do
      let(:merge_terms) { {"Template" => "1", "Report" => "1"} }
      let(:query) { Query::Type.new(search_term(merge_terms)) }

      it "returns an OR search query format for recomended and suggested projects" do
        query_str = "OR(SEARCH('Template', {Type of Resource}), SEARCH('Training', {Type of Resource}), SEARCH('Report', {Type of Resource}))"

        expect(query.query_string).to eq query_str
      end
    end
  end
end
