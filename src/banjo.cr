require "./banjo/*"

module Banjo
end

struct Nil
  def each(&block)
  end
end