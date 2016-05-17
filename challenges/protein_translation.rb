  # Attempt 1

# class InvalidCodonError < StandardError; end
  
# class Translation
  
#   CODON = { "AUG" => "Methionine", 
#     "UUU" => "Phenylalanine", "UUC" => "Phenylalanine", 
#     "UUA" => "Leucine", "UUG" => "Leucine", 
#     "UCU" => "Serine", "UCC" => "Serine", "UCA" => "Serine", "UCG" => "Serine", 
#     "UAU" => "Tyrosine", "UAC" => "Tyrosine", 
#     "UGU" => "Cysteine", "UGC" => "Cysteine", 
#     "UGG" => "Tryptophan", 
#     "UAA" => "STOP", "UAG" => "STOP", "UGA" => "STOP" }
  
#   def self.of_codon(sequence)
#     CODON[sequence] or raise InvalidCodonError 
#   end
  
#   def self.of_rna(strand)
#     strand.scan(/.../).map { |sequence| of_codon(sequence) }.take_while {|val| val != 'STOP' }
#   end

# end

# p Translation.of_codon('AUG')
# p Translation.of_codon('UAA')
# p Translation.of_codon('Carrot')

# p Translation.of_rna('UGGUGUUAUUAAUGGUUU')

# Attempt 2

class InvalidCodonError < StandardError; end
  
class Translation
  
  CODONS = { 
    "AUG" => "Methionine",    "UUU" => "Phenylalanine", 
    "UUC" => "Phenylalanine", "UUA" => "Leucine", 
    "UUG" => "Leucine",       "UCU" => "Serine", 
    "UCC" => "Serine",        "UCA" => "Serine", 
    "UCG" => "Serine",        "UAU" => "Tyrosine", 
    "UAC" => "Tyrosine",      "UGU" => "Cysteine", 
    "UGC" => "Cysteine",      "UGG" => "Tryptophan", 
    "UAA" => "STOP",          "UAG" => "STOP", 
    "UGA" => "STOP" 
  }
  
  def self.of_codon(codon)
    CODONS[codon] or raise InvalidCodonError 
  end
  
  def self.of_rna(strand)
    strand.scan(/.../).map { |codon| of_codon(codon) }.take_while {|codon| codon != 'STOP' }
  end
end
