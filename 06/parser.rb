class Parser
  def initialize(assembly_instructions)
    @assembly_instructions = assembly_instructions
    @machine_instructions = []
    puts @assembly_instructions
    @vars = Hash.new
    @vars["SP"] = 0
    @vars["LCL"] = 1
    @vars["ARG"] = 2
    @vars["THIS"] = 3
    @vars["THAT"] = 4
    @vars["R0"] = 0
    @vars["R1"] = 1
    @vars["R2"] = 2
    @vars["R3"] = 3
    @vars["R4"] = 4
    @vars["R5"] = 5
    @vars["R6"] = 6
    @vars["R7"] = 7
    @vars["R8"] = 8
    @vars["R9"] = 9
    @vars["R10"] = 10
    @vars["R11"] = 11
    @vars["R12"] = 12
    @vars["R13"] = 13
    @vars["R14"] = 14
    @vars["R15"] = 15
    @vars["SCREEN"] = 16384
    @vars["KBD"] = 24576
    @currVar = 16

    @labels = Hash.new
  end

  def parse
    currLine = 0
    @assembly_instructions.each do |instruction|
      if(instruction.start_with?('@'))

        hack_instructions.push(instruction)
      elsif

      end

  end
end
