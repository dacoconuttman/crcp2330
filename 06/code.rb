class Code

    DEST = {
      nil => "000",
      "M" => "001",
      "D" => "010",
      "MD" => "011",
      "A" => "100",
      "AM" => "101",
      "AD" => "110",
      "AMD" => "111"
    }

    JUMP = {
      nil => "000",
      "JGT" => "001",
      "JEQ" => "010",
      "JGE" => "011",
      "JLT" => "100",
      "JNE" => "101",
      "JLE" => "110",
      "JMP" => "111"
    }

    COMP = {
      "0" => "0101010",
      "1" => "0111111",
      "-1" => "0111010",
      "D" => "0001100",
      "A" => "0110000",
      "!D" => "0001101",
      "!A" => "0110001",
      "-D" => "0001111",
      "-A" => "0110011",
      "D+1" => "0011111",
      "A+1" => "0110111",
      "D-1" => "0001110",
      "A-1" => "0110010",
      "D+A" => "0000010",
      "D-A" => "0010011",
      "A-D" => "0000111",
      "D&A" => "0000000",
      "D|A" => "0010101",
      "M" => "1110000",
      "!M" => "1110001",
      "M+1"=> "1110111",
      "M-1" => "1110010",
      "D+M" => "1000010",
      "D-M" => "1010011",
      "M-D" => "1000111",
      "D&M" => "1000000",
      "D|M" => "1010101"
    }

    def dest(mnemonic)
      DEST[mnemonic]
    end

    def comp(mnemonic)
      COMP[mnemonic]
    end

    def jump(mnemonic)
      JUMP[mnemonic]
    end


  def initialize(instruction)
    @instruction = instruction
  end

  def parse
    output = "111"

    if @instruction.include?("=")
      temp_instruction = @instruction.partition("=")
      dest_part = DEST[temp_instruction[0]]
      comp_and_jump = temp_instruction[2]
    else
      dest_part = "000"
      comp_and_jump = @instruction
    end

    if comp_and_jump.include?(";")
      temp = comp_and_jump.partition(";")
      comp_part = COMP[comp_and_jump.partition(";")[0]]
      jump_part = JUMP[comp_and_jump.partition(";")[2]]
    else
      comp_part = COMP[comp_and_jump]
      jump_part = "000"
    end
    output << comp_part << dest_part << jump_part
  end

end
