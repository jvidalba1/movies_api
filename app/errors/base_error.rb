class BaseError < StandardError
  attr_accessor :params

  def initialize(params)
    super
  end
end
