class AirtableSearch
  attr_reader :terms

  def initialize(params = {})
    @terms = []

    params&.each do |field, query|
      @terms.push "Query::#{field.titleize}".constantize.new(query)
    end
  end

  def find_resources
    return [] if terms.empty?

    ProjectResource.search(terms.map(&:query_string))
  end
end
