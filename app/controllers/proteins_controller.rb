class ProteinsController < ApplicationController



  def index
    @proteins = Protein.all
  end

  def new
    @protein = Protein.new
  end

  def show
    @protein = Protein.find(params[:id])
  end

  def create

    @protein = Protein.new(protein_params)

    if @protein.save
      redirect_to proteins_path, flash: { success: "Successfully added protein #{@protein.name}." }
    else
      # render :new, flash: { fail: "Try again"}
    end

    def eSearch(name)
      uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi')
      # Defines params for dynamic GET request for eSearch
      params = { :db => "nucleotide", :term => name, :sort => "relevance" }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      @id = response.body if response.is_a?(Net::HTTPSuccess)
      return @id
    end

    def parseID(id)
      count = 0
      while count <1
        @id2 = /(?<=Id>)(.*?)(?=<\/Id)/.match(id)
        count += 1
      end
      return @id2
    end

    def eFetch(accession)
      uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi')
      params = { :db => "nucleotide", :id => accession, :rettype => "fasta", :retmode => "text"}
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      @seq = response.body if response.is_a?(Net::HTTPSuccess)
      return @seq
    end

    def parseSeq(seq)
      seqArray = []
      seq.split(/\n/).each do |i|
        seqArray << /\A((?!>.*).)*\z/.match(i)
      end
      @seq = seqArray.join
      return @seq
    end

    def convertThyUr(seq)
      # Replaces Ts with Us
      @seq = seq.gsub!("T","U")
    end

    # Calls the appropriate residue from the hash
    def convertAA(seq)
      rna_codons = {"UUU" => 'F', "UUC" => 'F', "UUA" => 'L', "UUG" => 'L',
                    "UCU" => 'S', "UCC" => 'S', "UCA" => 'S', "UCG" => 'S',
                    "UAU" => 'Y', "UAC" => 'Y', "UAA" => '-', "UAG" => '-',
                    "UGU" => 'C', "UGC" => 'C', "UGA" => '-', "UGG" => 'W',
                    "CUU" => 'L', "CUC" => 'L', "CUA" => 'L', "CUG" => 'L',
                    "CCU" => 'P', "CCC" => 'P', "CCA" => 'P', "CCG" => 'P',
                    "CAU" => 'H', "CAC" => 'H', "CAA" => 'Q', "CAG" => 'Q',
                    "CGU" => 'R', "CGC" => 'R', "CGA" => 'R', "CGG" => 'R',
                    "AUU" => 'I', "AUC" => 'I', "AUA" => 'I', "AUG" => 'M',
                    "ACU" => 'T', "ACC" => 'T', "ACA" => 'T', "ACG" => 'T',
                    "AAU" => 'N', "AAC" => 'N', "AAA" => 'K', "AAG" => 'K',
                    "AGU" => 'S', "AGC" => 'S', "AGA" => 'R', "AGG" => 'R',
                    "GUU" => 'V', "GUC" => 'V', "GUA" => 'V', "GUG" => 'V',
                    "GCU" => 'A', "GCC" => 'A', "GCA" => 'A', "GCG" => 'A',
                    "GAU" => 'D', "GAC" => 'D', "GAA" => 'E', "GAG" => 'E',
                    "GGU" => 'G', "GGC" => 'G', "GGA" => 'G', "GGG" => 'G'}
      i = 0
      residuesSeq = []
      while i < (seq.length / 3)
        residuesSeq << rna_codons[seq[i..(i + 2)]]
        i += 3
      end
      @aminoAcid = residuesSeq.join
      return @aminoAcid
    end

    def mw(seq)
    # MW is for mass upon addition (water is already gone)
    mw = {'A' => 71.03711, 'C' => 103.00919, 'D' => 115.02694, 'E' => 129.04259,
          'F' => 147.06841, 'G' => 57.02146, 'H' => 137.05891, 'I' => 113.08406,
          'K' => 128.09496, 'L' => 113.08406, 'M' => 131.04049, 'N' => 114.04293,
          'P' => 97.05276, 'Q' => 128.05858, 'R' => 156.10111, 'S' => 87.03203,
          'T' => 101.04768, 'V' => 99.06841, 'W' => 186.07931, 'Y' => 163.06333,
          # denotes carboxyamidomethylation, ~ denotes phosphorylation, @ denotes acetylation
          '#' => 57.02146, '~' => 79.96633, '@' => 42.01056}

      weight = []
      seq.scan(/./) do |i|
        weight << mw[i].to_f
      end
      @weight = weight.inject(:+)
      return (@weight).round(2)
    end

    if@protein.accession_number.empty?
      @protein.update_attributes(accession_number: parseID(eSearch("#{@protein.name}")))
    end

    if @protein.sequence.empty?
      @protein.update_attributes(sequence: convertAA(convertThyUr(parseSeq(eFetch(@protein.accession_number)))))
    end

    if @protein.weight.empty?
      @protein.update_attributes(weight: mw(@protein.sequence))
    end
  end

  def update
    @protein = Protein.find(params[:id])

    respond_to do |format|
      if @protein.update(protein_params)
        format.html { redirect_to @protein, notice: 'Protein was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def edit
    @protein = Protein.find(params[:id])
  end

   def destroy
    @protein = Protein.find(params[:id])

    @protein.destroy
    respond_to do |format|
      format.html { redirect_to proteins_url, notice: 'Protein was successfully removed from database.' }
      format.json { head :no_content }
    end
  end

  private
    def set_protein
      @protein = Protein.find(params[:id])
    end

    def protein_params
      params.require(:protein).permit(:name, :accession_number, :sequence, :weight, :iso_point)
    end
end
