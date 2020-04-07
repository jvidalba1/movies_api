class ParamsError < BaseError
  attr_accessor :params

  def initialize(params)
    super
  end
end
