class InvalidLineError < Exception; end

module LineValidationDSL
  # Allow us to pass in a regex, like /.css|.scss/, into our describe block
  # This will search through all of those files whenever we run a `lines` call
  def describe *args, &block
    if args.first.is_a?(Regexp)
      self.files_for_line_validations = Dir[Rails.root.join('app', '**', '**', '*')].select do |filename|
        filename =~ args.first
      end.map do |filename|
        [
          filename,
          File.read(filename).split("\n").delete_if(&:empty?)
        ]
      end
    end

    RSpec::Core::DSL::describe(*args, &block)
  end
end

def files_for_line_validations=(files)
  @@files_for_line_validations = files
end

def lines description, &block
  @@files_for_line_validations.each do |(filename, lines)|
    puts "checking"
    lines.each_with_index do |line, number|
      it(description) do
        begin
          if block.arity == 1
            yield line
          else
            yield line, number
          end
        rescue InvalidLineError
          raise "Invalid line ##{number} in #{filename}: #{line}"
        end
      end
    end
  end if @@files_for_line_validations
end

extend LineValidationDSL
