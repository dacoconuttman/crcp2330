require_relative "code"

class String
  def is_i?
    self.to_i.to_s == self
  end
end

class Parser

  def initialize(assembly_instructions)
    @assembly_instructions = assembly_instructions
    @machine_instructions = []
    @VARS = {
      "SP" => 0,
      "LCL" => 1,
      "ARG" => 2,
      "THIS" => 3,
      "THAT" => 4,
      "R0" => 0,
      "R1" => 1,
      "R2" => 2,
      "R3" => 3,
      "R4" => 4,
      "R5" => 5,
      "R6" => 6,
      "R7" => 7,
      "R8" => 8,
      "R9" => 9,
      "R10" => 10,
      "R11" => 11,
      "R12" => 12,
      "R13" => 13,
      "R14" => 14,
      "R15" => 15,
      "SCREEN" => 16384,
      "KBD" => 24576
    }

    @next_var = 16
    @LABELS = Hash.new
  end

  def parse
    curr_line = 1
    iter = 0

    @assembly_instructions.each do |instruction|
      if command_type(instruction) == :c_command
        curr_line += 1
      else

        if command_type(instruction) == :a_command
          sym_label = "("
          sym_label << instruction[1..-1]
          sym_label << ")"
          # #puts sym_label
          if @assembly_instructions.include?(sym_label)
            index = @assembly_instructions.index(sym_label) #- curr_line
            # #puts instruction
            # #puts index
            @LABELS[sym_label[1..-2]] = index - iter
            iter += 1

            # #puts @LABELS[index]
          else
            curr_line += 1
          end
        end
      end
    end

    puts @LABELS.inspect

    @assembly_instructions.each do |instruction|
      if command_type(instruction) == :a_command
        @machine_instructions << assemble_a_command(instruction)
      elsif command_type(instruction) == :c_command
        @machine_instructions << assemble_c_command(instruction)
      elsif command_type(instruction) == :label
        # sym_label = instruction[1..-2]
        # @LABELS[curr_line] = sym_label
      end
    end
    @machine_instructions
  end

  def command_type(instruction)
    if instruction.start_with?('@')
      return :a_command
    elsif instruction.start_with?('(')
      return :label
    else
      return :c_command
    end
  end

  def assemble_a_command(instruction)
    command = "0"
    command << constant(instruction[1..-1])
  end

  def constant(value)
    if(value.is_i?)
      temp = "%015b" % value
    else
      if(@LABELS[value] != nil)
        #puts value
        #puts @LABELS[value]
        temp = "%015b" % @LABELS[value]
        #puts temp
        #puts
      elsif(@VARS[value] != nil)
        #puts @VARS[value]
        #puts value
        temp = "%015b" % @VARS[value]
        #puts temp
        #puts
      else
        #puts value
        @VARS[value] = @next_var
        #puts @VARS[value]
        temp = "%015b" % @VARS[value]
        #puts temp
        #puts
        @next_var += 1
      end
    end
    return temp
  end

  def assemble_c_command(instruction)
    c_parser = Code.new(instruction)
    c_parser.parse
  end

end
