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

      redirect_to proteins_path, flash: { success: "#{@protein.sequence}"}
    else
      render :new
    end

    # if @protein.save
    #   accession("#{@protein.accession_number}")
    #   @protein.sequence = convertDNA(seq)
    #   convertyThyUr(seq)
    #   convertAA(seq)
    #   @protein.weight = mw(residuesSeq)

    #       def accession(accession)
    #         uri = URI('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi')
    #         params = { :db => "nucleotide", :id => accession, :rettype => "fasta", :retmode => "text"}
    #         uri.query = URI.encode_www_form(params)
    #         response = Net::HTTP.get_response(uri)
    #         seq = response.body if response.is_a?(Net::HTTPSuccess)
    #       end

    #       def convertDNA(seq)
    #         seqArray = []
    #         seq.split(/\n/).each do |i|
    #           seqArray << /\A((?!>.*).)*\z/.match(i)
    #         end
    #         seq = seqArray.join
    #       end

    #       def convertyThyUr(seq)
    #         # Replaces Ts with Us
    #         seq = seq.gsub!("T","U")
    #       end

    #       # Calls the appropriate residue from the hash
    #       def convertAA(seq)
    #         i = 0
    #         residuesSeq = []
    #         while i < (seq.length / 3)
    #           residuesSeq << rna_codons[seq[i..(i + 2)]]
    #           i += 3
    #         end
    #       end

    #       def mw(residuesSeq)
    #         weight = []
    #         residuesSeq.each do |i|
    #           weight << mw[i].to_f
    #         end
    #         mw = weight.join
    #       end

          #   redirect_to proteins_path(params[:id])
  end

  def update
  end

  private
    def set_protein
      @protein = Protein.find(params[:id])
    end

    def protein_params
      params.require(:protein).permit(:name, :accession_number, :sequence, :weight, :iso_point)
    end
end
