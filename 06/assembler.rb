#!/usr/bin/env ruby

require_relative 'parser'

class Assembler
  def initialize(asm_file, hack_file)
    @asm_file = asm_file
    @hack_file = hack_file
    @parser = Parser.new(instructions_from_file)
  end

  def assemble!
    hack_instructions = @parser.parse
    hack_instructions.each do |instruction|
      @hack_file << instruction << "\n"
    end
  end

  def instructions_from_file
    lines = @asm_file.readlines
    lines.each{|line| line.gsub! /\/\/.*/, '' ; line.strip!}
    lines.delete("")
    return lines
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
