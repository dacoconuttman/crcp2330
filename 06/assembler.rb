#!/usr/bin/env ruby

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

class Assembler
  def initialize(asm_file, hack_file)
    @asm_file = asm_file
    @hack_file = hack_file
    @asm_insructions = instructions_from_file
    p @asm_insructions
    @parser = Parser.new(@asm_insructions)
  end

  def assemble!
    # hack_instructions = Parser.parse_asm
    # @hack_file << hack_instructions
  end

  def instructions_from_file
    lines = @asm_file.readlines
    lines.each{|line| line.gsub! /\/\/.*/, '' ; line.strip!}
    lines.delete("")
  end

end

def args_valid?
  ARGV[0] && ARGV.length == 1 && ARGV[0].end_with?(".asm")
end

def file_valid?(path)
  File.exist?(path) && File.readable?(path)
end

def hack_filename(asm_filename)
  asm_basename = File.basename(asm_filename, '.asm')
  path = File.split(asm_filename)[0]
  "#{path}/#{asm_basename}.hack"
end

unless(args_valid?)
  abort("Usage: ./Assembler.rb Prog.asm")
end

asm_filename = ARGV[0]

unless(file_valid?(asm_filename))
  abort("Error: File not found or is unreadable")
end

File.open(asm_filename) do |asm_file|
  File.open(hack_filename(asm_filename), 'w') do |hack_file|
    assembler = Assembler.new(asm_file, hack_file)
    assembler.assemble!
  end
end
