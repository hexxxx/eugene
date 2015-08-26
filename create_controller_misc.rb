 @protein = Protein.new(protein_params)

    # @protein = Protein.new
    if @protein.save
      puts @protein.accession_number
    end

    #   redirect_to proteins_path(params[:id])
    #   flash[:succes] = "createdddd"
    # else
    #   #
    # end
    # require 'net/http'
    # require 'uri'

    # # Provides conversion for nucleotide chunks to amino acids
    # rna_codons = {"UUU" => 'F', "UUC" => 'F', "UUA" => 'L', "UUG" => 'L',
    #               "UCU" => 'S', "UCC" => 'S', "UCA" => 'S', "UCG" => 'S',
    #               "UAU" => 'Y', "UAC" => 'Y', "UAA" => '-', "UAG" => '-',
    #               "UGU" => 'C', "UGC" => 'C', "UGA" => '-', "UGG" => 'W',
    #               "CUU" => 'L', "CUC" => 'L', "CUA" => 'L', "CUG" => 'L',
    #               "CCU" => 'P', "CCC" => 'P', "CCA" => 'P', "CCG" => 'P',
    #               "CAU" => 'H', "CAC" => 'H', "CAA" => 'Q', "CAG" => 'Q',
    #               "CGU" => 'R', "CGC" => 'R', "CGA" => 'R', "CGG" => 'R',
    #               "AUU" => 'I', "AUC" => 'I', "AUA" => 'I', "AUG" => 'M',
    #               "ACU" => 'T', "ACC" => 'T', "ACA" => 'T', "ACG" => 'T',
    #               "AAU" => 'N', "AAC" => 'N', "AAA" => 'K', "AAG" => 'K',
    #               "AGU" => 'S', "AGC" => 'S', "AGA" => 'R', "AGG" => 'R',
    #               "GUU" => 'V', "GUC" => 'V', "GUA" => 'V', "GUG" => 'V',
    #               "GCU" => 'A', "GCC" => 'A', "GCA" => 'A', "GCG" => 'A',
    #               "GAU" => 'D', "GAC" => 'D', "GAA" => 'E', "GAG" => 'E',
    #               "GGU" => 'G', "GGC" => 'G', "GGA" => 'G', "GGG" => 'G'}


    # # MW is for mass upon addition (water is already gone)
    # mw = {'A' => 71.03711, 'C' => 103.00919, 'D' => 115.02694, 'E' => 129.04259,
    #       'F' => 147.06841, 'G' => 57.02146, 'H' => 137.05891, 'I' => 113.08406,
    #       'K' => 128.09496, 'L' => 113.08406, 'M' => 131.04049, 'N' => 114.04293,
    #       'P' => 97.05276, 'Q' => 128.05858, 'R' => 156.10111, 'S' => 87.03203,
    #       'T' => 101.04768, 'V' => 99.06841, 'W' => 186.07931, 'Y' => 163.06333,
    #       # denotes carboxyamidomethylation, ~ denotes phosphorylation, @ denotes acetylation
    #       '#' => 57.02146, '~' => 79.96633, '@' => 42.01056}

    # @protein = Protein.new(protein_params)

    # # if @protein.save
    # #   puts @protein.accession
    # # end

    # # class Protein < ActiveRecord::Base == true
    # #   validates :name, presence: true
    # # end

    # # if Protein.accession_saved?
    # #   puts @protein.accession
    # # end

    #     # need to get the sequence
    #     # then convert from DNA to RNA,
    #     # then chunk the RNA
    #     # convert to AAs
    #     # calculate MW from hash

    # if @protein.save
    #   redirect_to proteins_path
    #   flash[:success] = "created!"
    # end

    # puts conversion(@protein.accession_number)

    # def conversion(accession)

    # # Defines the URI for eSearch
    # uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi')

    # # Defines params for dynamic GET request for eSearch
    # # def accessionSearch(accession)
    #   params = { :db => "nucleotide", :id => accession, :sort => "relevance" }
    #   uri.query = URI.encode_www_form(params)
    #   response = Net::HTTP.get_response(uri)
    #   seq = response.body if response.is_a?(Net::HTTPSuccess)
    # end

    #   # seq4 = seq3.join.delete("\n")

    # # Defines the URI
    # # Defines params for dynamic GET request
    # # bobby recommends httparty
    # def accession(accession)
    #   uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi')
    #   params = { :db => "protein", :id => accession, :rettype => "fasta", :retmode => "text"}
    #   uri.query = URI.encode_www_form(params)
    #   response = Net::HTTP.get_response(uri)
    #   seq = response.body if response.is_a?(Net::HTTPSuccess)
    # end

    # def convertDNA(seq)
    #   seqArray = []
    #   seq.split(/\n/).each do |i|
    #     seqArray << /\A((?!>.*).)*\z/.match(i)
    #   end
    #   seq = seqArray.join
    # end

    # def convertyThyUr
    #   # Replaces Ts with Us
    #   seq.gsub!("T","U")
    # end

    # # Calls the appropriate residue from the hash
    # def convertAA(seq)
    #   i = 0
    #   residuesSeq = []
    #   while i < (seq.length / 3)
    #     residuesSeq << rna_codons[seq[i..(i + 2)]]
    #     i += 3
    #   end
    # end

    # def mw(residuesSeq)
    #   weight = []
    #   residuesSeq.each do |i|
    #     weight << mw[i].to_f
    #   end`
    # end


    # puts "The molecular weight of the protein is #{weight.inject(:+)}"

    # # puts seq


    #     puts residuesSeq.join

    # if @protein.save
    #             # Fetches SEQUENCE from GenBank
    #     # Sets ID (temporary. Will have user input the ID or name in the simple_form on proteins#new)
    #     accession = 296334
