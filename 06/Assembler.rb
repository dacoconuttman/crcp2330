#!/usr/bin/env ruby

#Creates a Hash of all the variable symbols, and stores an int to know where to
#create user-defined variables
vars = Hash.new
vars["SP"] = 0
vars["LCL"] = 1
vars["ARG"] = 2
vars["THIS"] = 3
vars["THAT"] = 4
vars["R0"] = 0
vars["R1"] = 1
vars["R2"] = 2
vars["R3"] = 3
vars["R4"] = 4
vars["R5"] = 5
vars["R6"] = 6
vars["R7"] = 7
vars["R8"] = 8
vars["R9"] = 9
vars["R10"] = 10
vars["R11"] = 11
vars["R12"] = 12
vars["R13"] = 13
vars["R14"] = 14
vars["R15"] = 15
vars["SCREEN"] = 16384
vars["KBD"] = 24576
nextVar = 16

#checks if the input file exists and is valid
if(!ARGV[0] || ARGV.length != 1 || !ARGV[0].end_with?(".asm") ||
  !File.exist?(ARGV[0]) || !File.readable?(ARGV[0]))
  abort("Usage: ./Assembler.rb Prog.asm")
end

puts ARGV[0]

filepath = ARGV[0]
