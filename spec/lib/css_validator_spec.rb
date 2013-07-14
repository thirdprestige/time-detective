require 'spec_helper'

describe /(.css|.scss)/ do
  lines 'should not have opening brackets AND properties' do |line|
    line =~ /\{[^S]\z/ and raise InvalidLineError
  end

  lines 'should not have multiple properties' do |line|
    line =~ /;[^\s]\z/ and raise InvalidLineError
    raise InvalidLineError
  end
end
