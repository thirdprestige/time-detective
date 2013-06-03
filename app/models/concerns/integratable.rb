module Integratable
  class Scaffold < Struct.new(:activity)
    %w(description hours).each do |method|
      define_method(method) do
        raise "Please implement `#{method}`"
      end
    end
  end

  def integration
    Scaffold.new(self)
  end
end
