class Query::Description
  attr_reader :value

  def initialize(value)
    @value = value

    Analytic.create(field: "Description", value: value)
  end

  def query_string
    "SEARCH('#{value}', {Description})"
  end
end
